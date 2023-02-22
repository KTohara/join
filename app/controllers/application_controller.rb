class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :persist_open_chat

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def turbo_prepend_alert
    turbo_stream.prepend('alert', partial: 'shared/alert')
  end

  def persist_open_chat
    return if controller_name == 'chats' && action_name == 'close'

    if session[:chat_id].present?
      chat = Chat.find(session[:chat_id])
      @chat = chat if [chat.user, chat.friend].include?(current_user)
      @friend = @chat.other_user(current_user)
    end
  end
end
