class UsersController < ApplicationController
  before_action :turbo_frame_request_variant, only: :index

  def index
    @users = User.search_by_user(params, current_user)
  end

  def show
    @user = User.find(params[:id])
    user_feed = @user.feed
      .with_attached_image
      .includes(:comments)
      .order(created_at: :desc)

    @pagy, @posts = pagy_countless(user_feed, items: 5)
    @new_post = @user.posts.build
  end

  def cancel_search
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'search_users', partial: 'shared/search', locals: { animate: 'animate-slideRight' }
        )
      end
      format.html { redirect_back fallback_location: posts_path }
    end
  end

  private

  # auto look for turbo frame for user search in #index
  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end