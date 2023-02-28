class MessagesController < ApplicationController
  include Notifiable

  before_action :authenticate_chat_users
  after_action -> { send_message_notification(@message, 'sent you a message') }, only: :create, if: -> { @message.persisted? }

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

  private

  def message_params
    params.require(:message).permit(:body, :image, :gif_url)
  end

  def turbo_replace_form
    render turbo_stream:
      turbo_stream.replace("form_chat_#{@chat.id}",
        partial: 'messages/form',
        locals: { chat: @chat, message: @chat.messages.build(user: current_user) }
      )
  end

  def send_message_notification(message, notification)
    send_notification(recipient: message.chat.other_user(current_user), notifiable: message.chat, message: notification)
  end
end