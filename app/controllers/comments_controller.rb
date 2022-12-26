class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_comment, only: %i[edit update]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream { flash.now[:notice] = 'Comment successful!' }
        format.html { redirect_to posts_path, notice: 'Comment successful!' }
      else
        format.html { redirect_to posts_path, alert: 'Something went wrong with your comment!' }
      end
    end
  end

  def edit; end

  def update
    @comment = @commentable.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream { flash.now[:notice] = 'Comment updated!' }
        format.html { redirect_to posts_path, notice: 'Comment successful!' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.turbo_stream { flash.now[:alert] = 'Comment deleted' }
      format.html { redirect_to posts_path, alert: 'Comment deleted' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end
