class FriendshipsController < ApplicationController
  include Notifiable

  after_action -> { send_friend_request_notification(@friendship, 'sent you a friend request') }, only: :create, if: -> { @friendship.persisted? }
  after_action -> { send_friend_request_notification(@friendship, 'accepted your friend request') }, only: :update, if: -> { @friendship.accepted? }
  after_action -> { destroy_original_friend_request_notification(@friendship) }, only: :update, if: -> { @friendship.accepted? }

  def index
    @friends = current_user.friends
    @friendship_requests = current_user.pending_requests
  end

  def create
    @friendship = current_user.friendships.build(friendship_params)

    if @friendship.save
      redirect_back fallback_location: friendships_path, notice: 'Friendship request sent'
    else
      redirect_back fallback_location: friendships_path, notice: "#{@friendship.friend.username} already sent you a request"
    end
  end

  def update
    @friendship = current_user.friendships.find_by(friend_id: params[:id])

    if @friendship.update(friendship_params)
      redirect_back fallback_location: friendships_path, notice: 'Friendship accepted'
    else
      redirect_back fallback_location: friendships_path, alert: 'Something went wrong!'
    end
  end

  def destroy
    @friendship = Friendship.find_by(friend_id: params[:id])
    return unless @friendship.destroy

    flash_msg = params[:request] == 'cancel' ? 'Request cancelled' : "#{@friendship.friend.username} removed as friend"
    redirect_back fallback_location: friendships_path, alert: flash_msg
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end

  def send_friend_request_notification(friendship, message)
    send_notification(recipient: friendship.friend, notifiable: friendship, message: message)
  end

  def destroy_original_friend_request_notification(friendship)
    # after user accepts a friend request on update,
    # destroys original friend request notification that the original user recieved
    # ie: 'other_user sent you a friend request'
    notification = Notification.find_by(recipient: current_user, sender: friendship.friend)
    notification.destroy
  end
end