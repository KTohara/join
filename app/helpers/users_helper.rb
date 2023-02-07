module UsersHelper
  def avatar_image(user, variant)
    if user.profile.avatar.attached?
      url_for(user.profile.avatar.variant(variant))
    elsebrand
      gravatar_url(user)
    end
  end

  def gravatar_url(user)
    size = 168
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
  end

  def oauth_icon(provider)
    case provider
    when :google_oauth2
      'fa-brands fa-google'
    when :facebook
      'fa-brands fa-facebook'
    when :github
      'fa-brands fa-github'
    end
  end

  def oauth_name(provider)
    case provider
    when :google_oauth2
      'Google'
    when :facebook
      'Facebook'
    when :github
      'GitHub'
    end
  end
end
