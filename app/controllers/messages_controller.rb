class MessagesController < ApplicationController
  before_action :authenticate_chat_users

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build(message_params)
    @message.user = current_user
    @message.save

    respond_to do |format|
      format.turbo_stream { turbo_replace_form }
      format.html { redirect_to @chat }
    end
  end

  def destroy

  end

  private

  def message_params
    params.require(:message).permit(:body, :image, :gif_url)
  end

  def authenticate_chat_users
    chat = Chat.find(params[:chat_id])
    authenticated = chat.values_at(:user_id, :friend_id).include?(current_user.id)
    redirect_to posts_path unless authenticated
  end

  def turbo_replace_form
    render turbo_stream:
      turbo_stream.replace("form_chat_#{@chat.id}",
        partial: 'messages/form',
        locals: { chat: @chat, message: @chat.messages.build(user: current_user) }
      )
  end
end