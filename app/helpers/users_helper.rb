module UsersHelper
  def avatar_image(user, variant)
    if user.profile.avatar.attached?
      url_for(user.profile.avatar.variant(variant))
    else
      gravatar_url(user)
    end
  end

  def gravatar_url(user)
    size = 168
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
  end
end
