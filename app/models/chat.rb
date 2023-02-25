# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_chats_on_friend_id              (friend_id)
#  index_chats_on_friend_id_and_user_id  (friend_id,user_id) UNIQUE
#  index_chats_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy

  scope :chatrooms, -> (users) { where('user_id = :user_id OR friend_id = :user_id', user_id: users) }

  def other_user(current_user)
    current_user == friend ? user : friend
  end

  def last_message
    messages.includes(:user, image_attachment: [:blob]).last
  end
end
