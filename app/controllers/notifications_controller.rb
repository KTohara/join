class NotificationsController < ApplicationController
  before_action :set_notifications, only: %i[unread read clear_all]

  def unread
    @notifications = @notifications.unread.limit(10)
  end

  def read
    @notifications = @notifications.read.limit(10)
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_back fallback_location: posts_path
  end

  def clear_all
    @notifications.destroy_all
    redirect_back fallback_location: posts_path
  end

  private

  def set_notifications
    @notifications = current_user.notifications.includes([:notifiable, :sender]).order(created_at: :desc)
  end
end
