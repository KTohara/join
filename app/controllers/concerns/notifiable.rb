module Notifiable
  private

  def send_commentable_notification(commentable, parent)
    # will not send a notificaiton if comment or post recipient is the current user
    # sends a notification to comment recipient first
    
    # in the case that the comment and post recipient are the same,
    # will not send notification (no need for duplicates)
    send_notification(parent) if valid_parent_user?(parent)
    send_notification(commentable) if valid_commentable_user?(commentable, parent)
  end

  # make into custom validation in model?
  def valid_parent_user?(parent)
    parent.present? && parent&.user != current_user
  end

  def valid_commentable_user?(commentable, parent)
    # check to see if commentable user is neither parent user or current user
    users = [current_user, parent.user]
    users.none? { |user| commentable.user == user }
  end

  def send_notification(notifiable)
    recipient = notifiable.user
    recipient.notifications.create(notifiable: notifiable, sender: current_user)
  end
end