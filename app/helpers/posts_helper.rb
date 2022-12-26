module PostsHelper
  def submit_button_text
    if action_name == 'index'
      'Post'
    else
      'Save'
    end
  end
end
