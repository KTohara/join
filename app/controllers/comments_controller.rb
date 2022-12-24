class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to posts_path, notice: 'Comment successful!' }
      else
        format.html { redirect_to posts_path, alert: 'Something went wrong with your comment!' }
      end
    end
  end

  def update; end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, notice: 'Comment deleted' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
