class ChatsController < ApplicationController
  before_action :authenticate_chat_users, only: %i[show close mark_read]

  def index
    @chats = Chat.chatrooms([current_user]).includes(:messages)
  end

  def show
    return unless session[:chat_id].present? || params[:id].present?
    
    @chat = Chat.find(params[:id])
    pagy_messages = @chat.messages.with_attached_image.includes(:user).order(created_at: :desc)
    @pagy, messages = pagy_countless(pagy_messages, items: 15)
    @messages = messages.reverse

    @friend = @chat.other_user(current_user)
    @keep_chat_open = params[:chat_open]
    session[:chat_id] = @chat.id

    respond_to do |f|
      f.turbo_stream
      f.html
    end
  end

  def new
    @chat = Chat.create
    @friend = User.find(params[:friend_id])
    @chat.users << [current_user, @friend]
  end

  def close
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

    unread_notifications.update_all(read: true)
    respond_to do |format|
      format.turbo_stream { turbo_replace_notification_counter }
      format.html
    end
  end

  private

  def turbo_replace_notification_counter
    notification_count = current_user.notifications.includes(:sender, :notifiable).unread.count
    render turbo_stream:
      turbo_stream.replace('notification_count',
        partial: 'notifications/counter',
        locals: { notification_count: notification_count }
      )
  end
end