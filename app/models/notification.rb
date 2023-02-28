# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  message         :string           not null
#  notifiable_type :string           not null
#  read            :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notifiable_id   :bigint           not null
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

  scope :read, -> { where(read: true).order(created_at: :asc) }
  scope :unread, -> { where(read: false).order(created_at: :asc) }

  after_create_commit do
    update_notification_count
  end

  after_destroy_commit do
    update_notification_count
  end

  def notification_message
    "#{sender.short_name.titleize} #{message}"
  end

  private

  def update_notification_count
    broadcast_replace_to [recipient.id, :notification_count],
      target: 'notification_count',
      partial: 'notifications/counter',
      locals: { notification_count: recipient.unread_notifications.count }
  end
end
