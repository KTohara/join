class PostsController < ApplicationController
  include Notifiable
  
  before_action :set_post, only: %i[show edit update destroy post_via_notification]
  before_action :set_new_post, only: %i[create update]
  before_action :mark_notification_as_read, only: %i[show post_via_notification]
  
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
      format.turbo_stream { turbo_replace_post_body }
      format.html
    end
  end

  def post_via_notification
    notification = Notification.find_by(id: params[:notification_id])
    return if notification.nil?
    
    set_post_variables(notification)
  end

  def create
    if post_params[:gif_url].present?
      @new_post.gif_url = post_params[:gif_url]
    end
    
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
    params.require(:post).permit(:body, :author_id, :user_id, :image, :gif_url)
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

  def set_post_variables(notification)
    notifiable = notification.notifiable
    case notification.notifiable_type
    when 'Comment'
      @comment = notifiable
      @parent = notifiable&.parent
    when 'Like'
      @comment = notifiable.likeable
    end
  end

  def turbo_replace_post_body
    render turbo_stream: [
      turbo_stream.replace(
        "post_body_#{@post.id}",
        partial: 'posts/post_body',
        locals: { post: @post }
      ),
      turbo_prepend_alert
    ]
  end

  def turbo_destroy_post
    render turbo_stream: [
      turbo_stream.remove(@post),
      turbo_prepend_alert
    ]
  end

  def turbo_show_notification_post
    notification = Notification.find(params[:notification_id])
    parent_comment = notification.notifiable.parent
    render turbo_stream: turbo_stream.replace(helpers.dom_id(@post, :comments),
      partial: 'comments/parent_comment',
      locals: { comment: parent_comment, user: current_user }
    )
  end
end
