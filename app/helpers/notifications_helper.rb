module NotificationsHelper
  def notifiable_link_type(notification)
    notifiable = notification.notifiable

    case notifiable.class.name
    when 'Comment'
      via_notification_path(notifiable.commentable, notification_id: notification.id)
    when 'Like'
      likeable = notifiable.likeable
      if likeable.class == Post
        post_path(likeable)
      else
        via_notification_path(likeable.commentable, notification_id: notification.id)
      end
    when 'Friendship'
      friendships_path
    end
  end

  def selected_color(button_type)
    "underline decoration-orange-400" if params[:notifications] == button_type
  end
end
