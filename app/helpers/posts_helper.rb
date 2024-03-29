module PostsHelper
  def submit_button_text
    if action_name == 'edit'
      'Save'
    else
      'Post'
    end
  end

  def form_placeholder_message(user)
    if user.present? && user != current_user
      "Post something to #{user.profile.first_name || user.username}"
    else
      "What's on your mind?"
    end
  end

  def rounded_top(controller)
    controller.controller_name == 'users' ? 'rounded-b-2xl' : 'rounded-2xl'
  end

  def via_notification_padding(parent)
    'pl-12' if parent.present?
  end
end
