module NotificationsHelper
  def notifiable_link_type(notification)
    case notification.notifiable_type
    when 'Post'
      post_path(notification.notifiable, notification_id: notification.id)
    when 'Comment'
      post_path(notification.notifiable.commentable, notification_id: notification.id)
    when 'Friendship'
      friendships_path(notification_id: notification.id)
    end
  end
end
