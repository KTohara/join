# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chat < ApplicationRecord
  has_many :chat_users, dependent: :destroy
  has_many :users, through: :chat_users
  has_many :messages, dependent: :destroy

  validates_length_of :chat_users, maximum: 2, message: 'maxium users reached'

  scope :chatrooms, -> (users) {
     joins(:users)
    .where(users: { id: users })
    .group('chats.id')
    .having('count(users.id) =?', users.count)
  }

  def other_user(current_user)
    users.where.not(id: current_user.id).first
  end

  def last_message
    messages.includes(:user).order(created_at: :desc).first
  end
end
