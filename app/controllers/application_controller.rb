class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery except: :create

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def turbo_prepend_alert
    turbo_stream.prepend('alert', partial: 'shared/alert')
  end

  def authenticate_chat_users
    chat_id = params[:id] || session[:chat_id]
    chat = Chat.find_by(id: chat_id)
    is_authenticated = ChatUser.where(user: current_user, chat: chat).present?
    redirect_to posts_path unless is_authenticated
  end
end
