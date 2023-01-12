module FriendshipsHelper
  def button_for_friendship_type(status, user)
    case status
    when 'accepted'
      tag.span('(placeholder) Message') +
      button_to('Remove Friend', friendship_path(user), params: { friendship: { friend_id: user.id} }, method: :delete, data: { turbo_confirm: 'Are you sure?' })
    when 'sent'
      button_to('Cancel Request', friendship_path(user), params: { request: :cancel }, method: :delete)
    when 'received'
      button_to('Accept', friendship_path(user), params: { friendship: { status: :accepted } }, method: :patch) +
      button_to('Decline', friendship_path(user), method: :delete, data: { turbo_confirm: 'Are you sure?' })
    else
      button_to('Add Friend', friendships_path, params: { friendship: { friend_id: user.id } }, method: :post)
    end
  end
end
