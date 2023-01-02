module FriendshipsHelper
  def button_for_friendship_type(status, user)
    case status
    when 'accepted'
      tag.div do
        tag.span '(placeholder) Message'
        button_to 'Remove Friend', friendship_path(user), method: :delete, data: { turbo_confirm: 'Are you sure?' }
      end
    when 'sent'
      button_to 'Cancel Request', friendship_path(user), params: { request: :cancel }, method: :delete
    when 'received'
      tag.div do
        button_to 'Accept', friendship_path(user), params: { friendship: { friend_id: user.id, status: :accepted } }, method: :patch
        button_to 'Decline', friendship_path(user), method: :delete, data: { turbo_confirm: 'Are you sure?' }
      end
    else
      button_to 'Add Friend', friendships_path, params: { friendship: { friend_id: user.id } }, method: :post
    end
  end
end
