module Commentable
  extend ActiveSupport::Concern
  include ActionView::RecordIdentifier
  include CommentsHelper
  include Notifiable

  included do
    after_action -> { send_comment_notification(@parent, @parent.user, 'replied to your comment') }, only: :create, if: -> { valid_parent_user?(@parent) }
    after_action -> { send_comment_notification(@commentable, @commentable.author, 'replied to your post') }, only: :create, if: -> { valid_commentable_user?(@commentable, @parent) }
  end

  def show_comments
    @max_comment_count = @parent.present? ? @parent.comments.count : @commentable.parent_comments.count
    @show_next_limit = params[:limit].to_i + 4
    @commentable ||= @parent

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
    params.require(:comment).permit(:body)
  end

  def send_comment_notification(comment_type, recipient, message)
    send_notification(
      recipient: recipient,
      notifiable: comment_type,
      message: message
    )
  end

  def valid_parent_user?(parent)
    parent.present? && parent&.user != current_user
  end

  def valid_commentable_user?(commentable, parent)
    # check to see if commentable user is neither parent user or current user
    users = [current_user, parent&.user].compact
    users.none? { |user| commentable.user == user }
  end
end