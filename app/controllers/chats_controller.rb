class ChatsController < ApplicationController
  def index
    @chats = Chat.chatrooms(current_user)
      .includes(
        :messages,
        user: [profile: [avatar_attachment: [:blob]]],
        friend: [profile: [avatar_attachment: [:blob]]]
      )
  end

  def show
    return unless session[:chat_id].present? || params[:id].present?

    @chat = Chat.find_or_create_by(id: params[:id])
    @messages = @chat.messages.includes(:user, image_attachment: [:blob])
    @friend = @chat.other_user(current_user)
    @user = current_user
    session[:chat_id] = @chat.id
  end

  def close
    @chat = Chat.find(params[:id])
    session.delete(:chat_id)
    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def mark_read
    @chat = Chat.find(params[:id])
    unread_notifications = Notification.where(recipient: current_user, notifiable: params[:id], read: false)
    return if unread_notifications.empty?

    unread_notifications.update(read: true)
    respond_to do |format|
      format.turbo_stream { turbo_replace_notification_counter }
      format.html
    end
  end

  private

  def turbo_replace_notification_counter
    notification_count = current_user.notifications.unread.count
    render turbo_stream:
      turbo_stream.replace('notification_count',
        partial: 'notifications/counter',
        locals: { notification_count: notification_count }
      )
  end
end