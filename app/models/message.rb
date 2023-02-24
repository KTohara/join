# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  body       :string
#  gif_url    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_chat_id  (chat_id)
#  index_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  has_one_attached :image, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: [260, 128]
  end

  after_create_commit do
    broadcast_create_to_message
  end

  def broadcast_create_to_message
    broadcast_append_later_to "container_chat_#{chat.id}",
      target: "messages",
      partial: 'messages/message',
      locals: { message: self }
  end
end
