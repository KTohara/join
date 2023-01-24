module PostsHelper
  def submit_button_text
    if action_name == 'edit'
      'Save'
    else
      'Post'
    end
  end

  def form_placeholder_message
    if @user.present? && @user != current_user
      "Post something to #{@user.name}"
    else
      "What's on your mind?"
    end
  end

  def formatted_date(object)
    object_creation_time = object.created_at
    if object_creation_time < 3.days.ago
      object.created_at.strftime('%B %e, %Y at %l:%M %p')
    else
      time_ago_in_words(object_creation_time)
    end
  end

  def rounded_top(controller)
    controller.controller_name == 'users' ? 'rounded-b-2xl' : 'rounded-2xl'
  end

  def via_notification_padding(parent)
    'pl-12' if parent.present?
  end

  # def parent_comment_collection(post, params)
  #   if posts_show? && params[:notification_id].present?
  #     find_post_comments_via_notification(post, params)
  #   else
  #     post.parent_comments.limit(1)
  #   end
  # end

  # def find_post_comments_via_notification(post, params)
  #   notification = Notification.find(params[:notification_id])
  #   # nesting = notification.notifiable.nesting - 1
    
  #   case notification_type(notification)
  #   when :comment then notifiable_post_comments(notification, post)
  #   when :post then post.comments.where(id: notification.notifiable_id)
  #   end
  # end

  # def notifiable_post_comments(notification, post)
  #   parent_id = notification.notifiable.parent_id
  #   # debugger

  #   post.comments
  #     .includes(:commentable, :user, :image_attachment)
  #     .where('parent_id = ? OR id = ?', parent_id, parent_id)
  # end

  # def notification_type(notification)
  #   if notification.notifiable.parent.nil?
  #     :post
  #   elsif notification.notifiable_type == 'Comment'
  #     :comment
  #   end
  # end

  # def posts_show?
  #   controller_name == 'posts' && action_name == 'show'
  # end

  # def find_root_comment(nesting)

  # end
end
