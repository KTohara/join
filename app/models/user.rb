# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  username               :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github, :facebook]

  has_many :friendships, dependent: :destroy
  has_many :pending_requests, -> { Friendship.pending }, class_name: 'Friendship'

  has_many :friends, -> { Friendship.accepted },
           through: :friendships,
           source: :friend
           
  has_one :profile, dependent: :destroy
  has_many :posts, -> { includes(%i[user author]) }, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender_id', dependent: :destroy
  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true # only allow letter, number, underscore and punctuation
  validate :validate_username

  after_create :create_profile
  
  # https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  attr_writer :login

  def self.search_by_user(params, current_user)
    users = User.includes(:profile).where.not(id: current_user.id)
    params[:q].blank? ? users : users.where('username ILIKE ?', "%#{sanitize_sql_like(params[:q])}%")
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.name.gsub(/\s+/, '').downcase
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.uid = auth.uid
    end
  end

  # devise login with username/email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
        { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
  
  # devise login with username/email
  def login
    @login || self.username || self.email
  end

  def feed
    friend_ids = "SELECT friend_id FROM friendships WHERE (user_id = :user_id AND status = '2')"
    Post.with_attached_image
        .includes(:comments, user: [:profile], author: [:profile])
        .where("user_id IN (#{friend_ids}) OR user_id = :user_id", user_id: id)
        .order(created_at: :desc)
  end

  def friendship_status(other_user)
    friendship = friendships.find_by(friend: other_user)
    return if friendship.nil?

    friendship.status
  end

  def liked?(likeable_object)
    likeable_object.likes.pluck(:user_id).include?(self.id)
  end

  def find_like(likeable_object)
    likes.find_by(likeable_id: likeable_object.id)
  end

  def unread_notifications
    notifications.where(read: false)
  end

  def profile_with_attached_avatar
    Profile.where(id: self.id).with_attached_avatar.first
  end

  def profile_name_blank?
    profile.first_name.blank? || profile.last_name.blank?
  end

  def name
    profile_name_blank? ? self.username : "#{profile.first_name} #{profile.last_name}"
  end

  def short_name
    profile_name_blank? ? self.username : profile.first_name
  end
  
  def find_chat(other_user)
    users = [self, other_user]
    Chat.chatrooms(users).first
  end

  def chat_exists?(other_user)
    find_chat(other_user).present?
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
