class ChatsController < ApplicationController
  def index
    @chats = Chat.chatrooms(current_user).includes(friend: [profile: [:avatar_attachment]])
  end

  def show
    @chat = Chat.find_or_create_by(id: params[:id])
  end

  def create

  end

  def destroy

  end
end