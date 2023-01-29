class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream do
          flash.now[:notice] = 'Comment updated!'
          render turbo_stream: [
            turbo_stream.replace(@comment, partial: 'comments/comment', locals: { comment: @comment, user: current_user }),
            turbo_prepend_alert
          ]
        end
        format.html { redirect_to posts_path, notice: 'Comment updated!' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream do
        flash.now[:alert] = 'Comment deleted'
        render turbo_stream: turbo_prepend_alert
      end
      format.html { redirect_to posts_path, alert: 'Comment deleted' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
