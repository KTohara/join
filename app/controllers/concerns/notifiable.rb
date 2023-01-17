module Notifiable
  private

  def send_notification(notifiable_args)
    current_user.sent_notifications.create(notifiable_args)
  end

  def mark_notification_as_read
    notification = Notification.find_by(id: params[:notification_id])
    return unless notification.present? || notification&.recipient == current_user

    notification.update(read: true)
  end
end