module FriendshipsHelper
  def friend_request_btn_class
    if show_page?
      return 'btn btn-sm'
    end
    'sm:btn sm:btn-sm'
  end

  def friend_request_icon_class
    if show_page?
      return 'hidden'
    end
    'text-orange-500 text-lg btn-icon sm:hidden'
  end

  def friend_request_p_class
    if show_page?
      return 'uppercase'
    end
    'sm:block hidden normal-case'
  end

  def show_page?
    if request.format.symbol == :turbo_stream && request.referer.split('/').slice(-2) == 'users'
      return true
    elsif controller_name == 'users' && action_name == 'show'
      return true
    end
    false
  end
end
