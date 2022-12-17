# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  status     :integer          default("pending"), not null
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
  after_create :create_inverse_friendship, if: :persisted?
  after_destroy :destroy_inverse_friendship, if: :destroyed?
  after_update :update_inverse_status, if: :will_save_change_to_status?

  enum status: {
    pending: 0,
    accepted: 1
  }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  scope :accepted, -> { where(status: :accepted) }
  scope :pending, -> { where(status: :pending) }

  def create_inverse_friendship
    friend.friendships.create(friend: user)
  end

  def destroy_inverse_friendship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end

  def update_inverse_status
    friendship = friend.friendships.find_by(friend: user)
    friendship.update_column(:status, status) if friendship
  end
end
