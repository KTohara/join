class NotificationsController < ApplicationController
  before_action :set_notifications, only: %i[index read clear_all]

  def index
    @notifications = if params[:notifications] == 'unread'
      @notifications.unread.limit(10)
    else
      @notifications.read.limit(10)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.turbo_stream { turbo_replace_notifications }
      format.html { redirect_back fallback_location: posts_path }
    end
  end

  def clear_all
    @notifications.destroy_all
    respond_to do |format|
      format.turbo_stream { turbo_replace_notifications }
      format.html { redirect_back fallback_location: posts_path }
    end
  end

  private

  def set_notifications
    @notifications = current_user.notifications.includes([:notifiable, :sender]).order(created_at: :desc)
  end

  def turbo_replace_notifications
    render turbo_stream:
    turbo_stream.replace(
      :notifications_list,
      partial: 'notifications/notifications',
      locals: { notifications: current_user.notifications.unread.order(created_at: :desc).limit(10) }
    )
  end
end
