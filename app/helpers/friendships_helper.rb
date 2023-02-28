module FriendshipsHelper
  def button_color
    is_show_page = controller_name == 'users' && action_name == 'show'
    is_show_page ? 'text-slate-200' : 'text-slate-400'
  end
end
