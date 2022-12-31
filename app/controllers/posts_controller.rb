class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_new_post, only: %i[create]

  def index
    @posts = current_user.feed
    @post = current_user.posts.build
  end

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
    if @post.update(post_params)
      redirect_to posts_url
    else
      @posts = current_user.feed
      flash[:alert] = 'Something went wrong with your post!'
      render :index, status: :unprocessable_entity
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
end
