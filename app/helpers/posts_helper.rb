module PostsHelper
  def submit_button_text
    if action_name == 'index' || action_name == 'show'
      'Post'
    else
      'Save'
    end
  end

  def form_placeholder_message
    if @user.present? && @user != current_user
      "Post something to #{@user.username}"
    else
      "What's on your mind?"
    end
  end
end
