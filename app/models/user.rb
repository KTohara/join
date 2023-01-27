# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
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
         :recoverable, :rememberable, :validatable

  # Friendships
  has_many :friendships, dependent: :destroy
  has_many :pending_requests, -> { Friendship.pending }, class_name: 'Friendship'

  # Friends
  has_many :friends, -> { Friendship.accepted },
           through: :friendships,
           source: :friend
  has_many :pending_friends, -> { Friendship.pending },
           through: :friendships,
           source: :friend

  # Posts
  has_many :posts, -> { includes(%i[user author]) }, dependent: :destroy
  has_many :friends_posts, through: :friends, source: :posts

  # Comments
  has_many :comments, dependent: :destroy

  # Likes
  has_many :likes, dependent: :destroy

  # Profile
  has_one :profile, dependent: :destroy

  # Notifications
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender_id', dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  after_create :create_profile

  def self.search_by_user(params, current_user)
    users = includes(profile: [:avatar_attachment]).where.not(id: current_user.id)
    params[:q].blank? ? users : users.includes(profile: [:avatar_attachment]).where('username ILIKE ?', "%#{sanitize_sql_like(params[:q])}%")
  end

  def feed
    friend_ids = "SELECT friend_id FROM friendships WHERE (user_id = :user_id AND status = '2')"
    Post.with_attached_image
        .includes([:image_attachment, :comments, :author, user: [:profile]])
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

  def name
    name_blank? ? self.username : "#{profile.first_name} #{profile.last_name}"
  end

  def name_blank?
    profile.first_name.blank? || profile.last_name.blank?
  end

  def first_name
    profile.first_name if profile.first_name.present?
  end
end
