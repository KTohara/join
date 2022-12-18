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

  # FRIENDSHIPS
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { Friendship.accepted },
            through: :friendships,
            source: :friend
  has_many :pending_friends, -> { Friendship.pending },
            through: :friendships,
            source: :friend

  # POSTS
  has_many :posts, dependent: :destroy
  has_many :friends_posts, through: :friends, source: :posts

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  scope :query, -> search { where('LOWER(username) LIKE ?', "%#{search.downcase}%") }

  def feed
    friends_posts.or(posts).distinct.order(created_at: :desc)
  end
end
