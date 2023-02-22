class ChatsController < ApplicationController
  def index
    @chats = Chat.chatrooms(current_user).includes(friend: [profile: [:avatar_attachment]])
  end

  def show
    return unless session[:chat_id].present? || params[:id].present?

    @chat = Chat.find_or_create_by(id: params[:id])
    @friend = @chat.other_user(current_user)
    session[:chat_id] = @chat.id
    # respond_to do |format|
    #   format.turbo_stream do
    #     render turbo_stream:
    #       turbo_stream.replace(
    #         "persisted_chat_#{@chat.id}",
    #         partial: 'chats/chat',
    #         locals: { chat: @chat, friend: @friend, open: true }
    #       )
    #   end
    #   format.html
    # end
  end

  def close
    @chat = Chat.find(params[:id])
    session.delete(:chat_id)
    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def create

  end

  def destroy

  end
end