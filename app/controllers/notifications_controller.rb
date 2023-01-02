class NotificationsController < ApplicationController
  def index
    notifications = current_user.unread_notifications.order(created_at: :desc).limit(10)
    @unread = notifications.unread
    @read = notifications.read
  end

  def destroy
    @notification = Notification.find(params[:id])
    # @notification.destroy
    redirect_back fallback_location: posts_path
  end

  def clear_all
    # @unread.destroy_all
    redirect_back fallback_location: posts_path
  end
end
