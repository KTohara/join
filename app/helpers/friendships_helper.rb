module FriendshipsHelper
  def button_for_friendship_type(status, user)
    case status
    when 'accepted'
      button_to('Message', user, params: { friendship: { friend_id: user.id} }, method: :get, class: 'btn-sm normal-case') +
      button_to('Remove', friendship_path(user), params: { friendship: { friend_id: user.id} }, method: :delete, data: { turbo_confirm: 'Are you sure?' }, class: 'btn-sm normal-case')
    when 'sent'
      button_to('Cancel', friendship_path(user), params: { request: :cancel, friendship: { friend_id: user.id} }, method: :delete, class: 'btn-sm normal-case')
    when 'received'
      button_to('Accept', friendship_path(user), params: { friendship: { status: :accepted } }, method: :patch, class: 'btn-sm normal-case') +
      button_to('Decline', friendship_path(user), method: :delete, data: { turbo_confirm: 'Are you sure?' }, class: 'btn-sm normal-case')
    else
      button_to('Add', friendships_path, params: { friendship: { friend_id: user.id } }, method: :post, class: 'btn-sm normal-case')
    end
  end
end
