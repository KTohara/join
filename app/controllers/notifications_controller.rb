class NotificationsController < ApplicationController
  before_action :set_notifications, only: %i[index read destroy clear_all]

  def index
    @unread = @notifications.unread.limit(10).includes(notifiable: [:chat], sender: [:profile])
    @read = @notifications.read.limit(10).includes(notifiable: [:chat], sender: [:profile])
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_replace_notifications }
      format.html { redirect_back fallback_location: posts_path }
    end
  end

  def clear_all
    @notifications.destroy_all
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_replace_notifications }
      format.html { redirect_back fallback_location: posts_path }
    end
  end

  private

  def set_notifications
    @notifications = current_user.notifications.order(created_at: :desc)
    @unread = @notifications.unread.limit(10)
    @read = @notifications.read.limit(10)
  end

  def turbo_replace_notifications
    turbo_stream.replace(
      :notifications_list,
      partial: 'notifications/notifications',
      locals: { unread: @unread, read: @read, animate: false }
    )
  end
end
