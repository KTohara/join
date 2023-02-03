module NotificationsHelper
  def notifiable_link_type(notification)
    notifiable = notification.notifiable

    case notifiable.class.name
    when 'Comment'
      via_notification_path(notifiable.commentable, notification_id: notification.id)
    when 'Like'
      likeable = notifiable.likeable
      if likeable.class == Post
        post_path(likeable, notification_id: notification.id)
      else
        via_notification_path(likeable.commentable, notification_id: notification.id)
      end
    when 'Friendship'
      friendships_path
    end
  end

  def animation(animate)
    'animate-slideLeft' if animate == true
  end
end
