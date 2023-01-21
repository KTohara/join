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
end
