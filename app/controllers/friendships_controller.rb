class FriendshipsController < ApplicationController
  include Notifiable

  after_action -> { send_friend_request_notification(@friendship, 'sent you a friend request') }, only: :create
  after_action -> { send_friend_request_notification(@friendship, 'accepted your friend request') }, only: :update, if: -> { @friendship.accepted? }
  
  def index
    @friends = current_user.friends
    @friendship_requests = current_user.pending_requests
  end

  def create
    @friendship = current_user.friendships.build(friendship_params)
    return unless @friendship.save

    flash[:notice] = 'Friendship request sent'
    redirect_back fallback_location: users_path
  end

  def update
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    return unless @friendship.update(friendship_params)

    flash[:notice] = 'Friendship accepted'
    redirect_back fallback_location: users_path
  end

  def destroy
    @friendship = Friendship.find_by(friend_id: params[:id])
    return unless @friendship.destroy

    flash_msg = params[:request] == 'cancel' ? 'Request cancelled' : "#{@friendship.friend.username} removed as friend"
    redirect_back fallback_location: users_path, alert: flash_msg
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end

  def send_friend_request_notification(friendship, message)
    if friendship.accepted? # destroys original friend request notification ie: 'other_user sent you a friend request'
      notification = Notification.find_by(recipient: current_user, sender: friendship.friend)
      notification.destroy
    end
    send_notification(recipient: friendship.friend, notifiable: friendship, message: message)
  end
end
