class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(auth)

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      set_flash_message(:notice, :failure, { kind: 'Google', reason: "#{auth.info.email} is not authorized" })
      session['devise.google_data'] = auth.except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def facebook
    user = User.from_omniauth(auth)

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      set_flash_message(:notice, :failure, { kind: 'Facebook', reason: "#{auth.info.email} is not authorized" })
      session['devise.facebook_data'] = auth.except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def github
    user = User.from_omniauth(auth)

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      set_flash_message(:notice, :failure, { kind: 'Github', reason: "#{auth.info.email} is not authorized" })
      session['devise.github_data'] = auth.except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end