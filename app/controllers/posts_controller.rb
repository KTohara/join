class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_new_post, only: %i[create]
  before_action :remove_notification, only: :show, if: :notified?
  
  def index
    @posts = current_user.feed
    @new_post = current_user.posts.build
  end

  def show; end

  def create
    if @post.save
      redirect_back fallback_location: posts_url, notice: 'Post successful!'
    else
      @posts = current_user.feed
      flash.now[:alert] = 'Something went wrong with your post!'
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash.now[:alert] = 'Post has been updated'
        format.turbo_stream { turbo_replace_post_body }
        format.html { redirect_back fallback_location: posts_url }
      else
        @posts = current_user.feed
        flash.now[:alert] = 'Something went wrong with your post!'
        format.turbo_stream { turbo_replace_post_body }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, alert: 'Post deleted!'
  end

  private

  def post_params
    params.require(:post).permit(:body, :author_id, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_new_post
    if params[:post][:user_id]
      @user = User.find(params[:post][:user_id])
      return @post = @user.posts.build(post_params)
    end
    @post = current_user.posts.build(post_params)
  end

  def turbo_replace_post_body
    render turbo_stream: [
      turbo_stream.replace("post_body_#{@post.id}", partial: 'posts/post_body', locals: { post: @post, current_user: current_user }),
      turbo_stream.prepend('alert', partial: 'shared/alert')
    ]
  end

  def notified?
    params[:read] == 'true'
  end

  def remove_notification

    @notification = Notification.find(params[:id])
    debugger
    # @notification.destroy
  end
end
