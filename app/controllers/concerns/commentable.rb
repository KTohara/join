module Commentable
  extend ActiveSupport::Concern
  include ActionView::RecordIdentifier
  include CommentsHelper

  included do
    before_action :authenticate_user!
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.nesting = @comment.set_nesting(@parent)
    
    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          flash.now[:notice] = comment_flash_message
          turbo_replace_saved_comment_form
        end
        format.html { redirect_to posts_path, notice: 'Comment successful!' }
      else
        format.turbo_stream { turbo_replace_unsaved_comment_form }
        format.html { redirect_to posts_path, alert: 'Something went wrong with your comment!' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def turbo_replace_saved_comment_form
    if @parent.present?
      replace_parent_form
    else
      replace_commentable_form
    end
  end

  def replace_parent_form
    comment = Comment.new
    render turbo_stream: [
      turbo_stream.replace(
        dom_id_for_comment(@parent, comment),
        partial: 'comments/form',
        locals: { commentable: @parent, comment: comment, data: { comment_reply_target: :form}, class: 'hidden' }
      ),
      turbo_stream.prepend('alert', partial: 'shared/alert')
    ]
  end

  def replace_commentable_form
    comment = Comment.new
    render turbo_stream: [
      turbo_stream.replace(
        dom_id_for_comment(@commentable, comment),
        partial: 'comments/form',
        locals: { commentable: @commentable, comment: comment }
      ),
      turbo_stream.prepend('alert', partial: 'shared/alert')
    ]
  end

  def turbo_replace_unsaved_comment_form
    render turbo_stream: turbo_stream.replace(
      dom_id_for_comment(@parent || @commentable, @comment),
      partial: 'comments/form',
      locals: { commentable: @parent || @commentable, comment: @comment }
    )
  end

  def comment_flash_message
    if params[:controller] == 'comments/comments'
      'Reply successful!'
    else
      'Comment successful!'
    end
  end
end