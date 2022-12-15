class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[destroy update]

  def index
    @feed = current_user.posts
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_url, notice: 'Post successful!'
    else
      @posts = current_user.posts
      flash.now[:alert] = 'Something went wrong with your post!'
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_url, status: :ok
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, status: :ok
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end

    def set_post
      @post = Post.find_by(id: params[:id])
    end
end
