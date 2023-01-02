# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  notifiable_type :string
#  read            :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notifiable_id   :bigint
#  recipient_id    :bigint           not null
#  sender_id       :bigint           not null
#
# Indexes
#
#  index_notifications_on_notifiable    (notifiable_type,notifiable_id)
#  index_notifications_on_recipient_id  (recipient_id)
#  index_notifications_on_sender_id     (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipient_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  scope :read, ->{ where(read: true) }
  scope :unread, ->{ where(read: false) }

  def message
    "#{sender.username.humanize} #{notifiable_message_type}"
  end

  def notifiable_message_type
    case notifiable_type
    when 'Post'
      'commented on your post'
    when 'Comment'
      'replied to your comment'
    when 'Friendship'
      'sent you a friend request'
    when 'Like'
      "liked your #{notifiable.likeable_type.downcase}"
    end
  end
end
