class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to posts_path, notice: 'Comment successful!'
    else
      flash[:alert] = 'Something went wrong with your comment!'
      redirect_to posts_path, status: :unprocessable_entity
    end
  end

  def update

  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to posts_path, notice: 'Comment deleted'
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end
