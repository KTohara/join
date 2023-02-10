class FriendshipsController < ApplicationController
  include Notifiable

  after_action -> { send_friend_request_notification(@friendship, 'sent you a friend request') }, only: :create, if: -> { @friendship.persisted? }
  after_action -> { send_friend_request_notification(@friendship, 'accepted your friend request') }, only: :update, if: -> { @friendship.accepted? }
  after_action -> { destroy_original_friend_request_notification(@friendship) }, only: :update, if: -> { @friendship.accepted? }

  def index
    @friends = current_user.friends
    @friend_requests = current_user.pending_requests.includes([friend: [profile: [:avatar_attachment]]])
  end

  def create
    @friendship = current_user.friendships.build(friendship_params)
    @user = @friendship.friend

    flash.now[:notice] = if @friendship.save
      'Friendship request sent'
    else
      "#{@friendship.friend.username} already sent you a request"
    end

    respond_to do |format|
      format.turbo_stream { turbo_stream_replace_friend_request }
    end
  end

  def update
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @user = @friendship.friend

    if @friendship.update(friendship_params)
      flash.now[:notice] = 'Friendship accepted'
    else
      flash.now[:alert] = 'Something went wrong!'
    end

    respond_to do |format|
      format.turbo_stream { turbo_stream_replace_friend_request }
    end
  end

  def destroy
    @friendship = Friendship.find_by(friend_id: params[:id])
    @user = User.find_by(id: params[:friendship][:friend_id]) if params[:friendship]

    respond_to do |format|
      @friendship.destroy unless @friendship.nil? # guard clause due to removing friends while two users are trying to delete the friendship
      flash.now[:alert] = case params[:request]
        when 'cancel' then 'Request cancelled'
        when 'declined' then 'Friend request declined'
        else "#{@user.username} removed as friend"
      end

      format.turbo_stream { turbo_stream_replace_friend_request }
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end

  def turbo_stream_replace_friend_request
    render turbo_stream: [
      turbo_stream.replace_all(".friend_user_#{@user.id}", partial: 'friendships/button_type', locals: { status: current_user.friendship_status(@user), user: @user}),
      turbo_prepend_alert
    ]
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