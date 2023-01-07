# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  status     :integer          default("sent"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_friendships_on_friend_id              (friend_id)
#  index_friendships_on_friend_id_and_user_id  (friend_id,user_id) UNIQUE
#  index_friendships_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Friendship < ApplicationRecord
  enum status: {
    sent: 0,
    received: 1,
    accepted: 2
  }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user_id }

  after_create :create_inverse_friendship, if: -> { persisted? && inverse_not_created }
  after_destroy :destroy_inverse_friendship, if: :destroyed?
  after_update :update_inverse_status

  scope :accepted, -> { where(status: :accepted) }
  scope :pending, -> { where(status: %i[sent received]) }

  def inverse_not_created
    Friendship.find_by(user: friend, friend: user).nil?
  end

  def create_inverse_friendship
    friend.friendships.create(friend: user, status: :received)
  end

  def destroy_inverse_friendship
    friendship = friend.friendships.find_by(friend: user)
    friendship&.destroy
  end

  def update_inverse_status
    friendship = friend.friendships.find_by(friend: user)
    friendship&.update_column(:status, status)
  end
end
