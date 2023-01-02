module NotificationsHelper
  def link_for_notifiable_type(notification)
    case notification.notifiable_type
    when 'Post'
      post_path(notification.notifiable, read: true)
    when 'Comment'
      post_path(notification.notifiable.commentable, read: true)
    when 'Friendship'
      friendships_path(read: true)
    end
  end
end
