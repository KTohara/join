module NotificationsHelper
  def notifiable_link_type(notification)
    notifiable = notification.notifiable
    
    case notifiable.class.name
    when 'Post'
      post_path(notifiable, notification_id: notification.id)
    when 'Comment'
      post_path(notifiable.commentable, notification_id: notification.id)
    when 'Like'
      likeable = notifiable.likeable
      url_object = likeable.class == Post ? likeable : likeable.commentable
      post_path(url_object, notification_id: notification.id)
    when 'Friendship'
      friendships_path(notification_id: notification.id)
    end
  end
end
