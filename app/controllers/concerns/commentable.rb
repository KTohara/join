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
    find_turbo_comments_to_reject(params)
    set_show_comments

    @pagy, @comments = pagy_countless(@comments, items: 5)
    session.delete(:turbo_comments) if @pagy.next.nil?

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

  def reject_preloaded_comments(turbo_comments = nil)
    if @parent.present?
      @parent.parent_comments_to_load(turbo_comments)
    else
      @commentable.post_comments_to_load(turbo_comments)
    end
  end

  def find_turbo_comments_to_reject(params)
    comment_ids = params.select { |param| param.starts_with?('reject_comments') }.values
    return if comment_ids.empty?

    if session[:turbo_comments].nil?
      session[:turbo_comments] = comment_ids
    else
      session[:turbo_comments].concat(comment_ids)
    end
  end

  def set_show_comments
    if session[:turbo_comments].present?
      turbo_comments_to_reject = Comment.where(id: session[:turbo_comments])
      @comments = reject_preloaded_comments(turbo_comments_to_reject)
    else
      @comments = reject_preloaded_comments if @pagy.blank?
    end
  end
end