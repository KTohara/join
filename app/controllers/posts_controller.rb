class PostsController < ApplicationController
  include Notifiable
  
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_new_post, only: %i[create update]
  before_action :mark_notification_as_read, only: :show
  
  def index
    @pagy, @posts = pagy_countless(current_user.feed, items: 5)
    @new_post = current_user.posts.build
    
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
      format.turbo_stream { turbo_cancel_post_edit }
    end
  end

  def create
    respond_to do |format|
      if @new_post.save
        flash[:alert] = 'Post successful'
        format.turbo_stream
        format.html { redirect_back fallback_location: posts_url }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:alert] = 'Post has been updated'
        format.turbo_stream { turbo_replace_post_body }
        format.html { redirect_back fallback_location: posts_url }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    flash.now[:alert] = @post&.destroy ? 'Post deleted!' : 'Post not found'

    respond_to do |format|
      if @post.destroy
        format.turbo_stream { turbo_destroy_post }
        format.html { redirect_back fallback_location: posts_url }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :author_id, :user_id, :image)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def set_new_post
    if post_params[:user_id].present?
      @user = User.find(post_params[:user_id])
      @pagy, @posts = pagy(@user.posts.order(created_at: :desc), items: 5)
      return @new_post = @user.posts.build(post_params)
    end
    @pagy, @posts = pagy(current_user.feed, items: 5)
    @new_post = current_user.posts.build(post_params)
  end

  def turbo_replace_post_body
    render turbo_stream: [
      turbo_stream.replace(
        "post_body_#{@post.id}",
        partial: 'posts/post_body',
        locals: { post: @post, user: current_user }
      ),
      turbo_prepend_alert
    ]
  end

  def turbo_cancel_post_edit
    render turbo_stream:
      turbo_stream.replace(
        "post_form",
        partial: 'posts/post_body',
        locals: { post: @post }
      )
  end

  def turbo_destroy_post
    render turbo_stream: [
      turbo_stream.remove(@post),
      turbo_prepend_alert
    ]
  end
end
