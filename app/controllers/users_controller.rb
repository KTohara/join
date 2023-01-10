class UsersController < ApplicationController
  before_action :turbo_frame_request_variant, only: :index

  def index
    @users = User.search_by_user(params, current_user)

  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy_countless(@user.posts.order(created_at: :desc), items: 5)
    @post = @user.posts.build

    respond_to do |format|
      format.html # for regular get request
      format.turbo_stream # for pagy post request
    end
  end

  private

  # auto look for turbo frame for user search in #index
  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end