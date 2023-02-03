class NotificationsController < ApplicationController
  before_action :set_notifications, only: %i[index read clear_all]

  def index
    # @notifications = if params[:notifications] == 'unread'
    @unread = @notifications.unread.limit(10)
    @read = @notifications.read.limit(10)

    # respond_to do |format|
    #   format.turbo_stream do
    #     render turbo_stream:
    #       # turbo_replace_button(params[:animate]),
    #       turbo_replace_notifications(params[:animate])
    #   end
    #   format.html
    # end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    # @notifications = current_user.notifications.unread.order(created_at: :desc).limit(10)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_replace_notifications }
      format.html { redirect_back fallback_location: posts_path }
    end
  end

  def clear_all
    @notifications.destroy_all
    respond_to do |format|
      # @notifications = current_user.notifications.unread.order(created_at: :desc).limit(10)

      format.turbo_stream { render turbo_stream: turbo_replace_notifications }
      format.html { redirect_back fallback_location: posts_path }
    end
  end

  private

  def set_notifications
    @notifications = current_user.notifications.includes([:notifiable, :sender]).order(created_at: :desc)
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

  # def turbo_replace_button(animate)
  #   animate = animate == 'animate-slideLeft' ? 'animate-slideOut' : 'animate-slideLeft'
  #   turbo_stream.replace(
  #     :notification_btn,
  #     partial: 'notifications/button',
  #     locals: { animate: animate }
  #   )
  # end
end
