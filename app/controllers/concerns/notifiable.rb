module Notifiable
  private

  def send_notification(notifiable_args)
    current_user.sent_notifications.create(notifiable_args)
  end

  def mark_notification_as_read
    notification = Notification.find(params[:notification_id])
    return unless notification.present? || notification.recipient == current_user

    notification.update(read: true)
    redirect_back fallback_location: posts_path
  end
end