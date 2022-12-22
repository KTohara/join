class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[new create update]

  def new
    @comment = @commentable.comments.build(comment_params)
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to posts_path, notice: 'Comment successful!'
    else
      flash[:alert] = 'Something went wrong with your comment!'
      render :new, status: :unprocessable_entity
    end
  end

  def update

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to posts_url, notice: 'Comment deleted'
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_commentable
      @commentable = params[:post_id].present? ? set_post : set_comment
    end

    def set_post
      Post.find(params[:post_id])
    end

    def set_comment
      comment = Comment.find(params[:comment_id])
      comment.commentable_type == 'Comment' ? comment.commentable : comment
    end
end
