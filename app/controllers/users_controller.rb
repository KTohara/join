class UsersController < ApplicationController
  before_action :turbo_frame_request_variant, only: :index

  def index
    @users = User.search_by_user(params, current_user)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user).order(created_at: :desc)
    @post = @user.posts.build
  end

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end