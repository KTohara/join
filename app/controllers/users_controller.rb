class UsersController < ApplicationController
  before_action :turbo_frame_request_variant, only: :index

  def index
    @users = User.search_by_user(params, current_user)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.includes(:comments, :image_attachment).order(created_at: :desc), items: 5)
    @new_post = @user.posts.build

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  # auto look for turbo frame for user search in #index
  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end