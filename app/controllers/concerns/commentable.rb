module Commentable
  extend ActiveSupport::Concern
  include ActionView::RecordIdentifier
  include CommentsHelper
  include Notifiable

  included do
    after_action -> { send_comment_notification(@comment, @parent.user, 'replied to your comment') },
      only: :create, if: -> { valid_parent_user?(@parent) && @comment.persisted? }
    
    after_action -> { send_comment_notification(@comment, @commentable.author, 'replied to your post') },
      only: :create, if: -> { valid_commentable_user?(@commentable, @parent) && @comment.persisted? }
  end

  def show_comments
    @comments = reject_preloaded_comments if @pagy.blank?
    @pagy, @comments = pagy_countless(@comments, items: 5)
    
    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.nesting = @comment.set_nesting(@parent)
    
    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to posts_path, notice: 'Comment successful!' }
      else
        format.html { redirect_to posts_path, alert: 'Something went wrong with your comment!' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image)
  end

  def send_comment_notification(comment_type, recipient, message)
    send_notification(
      notifiable: comment_type,
      recipient: recipient,
      message: message
    )
  end

  def valid_parent_user?(parent)
    parent.present? && parent&.user != current_user
  end

  def valid_commentable_user?(commentable, parent)
    # check to see if commentable user is neither parent user or current user
    users = [current_user, parent&.user].compact
    users.none? { |user| commentable.author == user }
  end

  def reject_preloaded_comments
    if @parent.present?
      @parent.parent_comments_to_load
    else
      @commentable.post_comments_to_load
    end
  end
end