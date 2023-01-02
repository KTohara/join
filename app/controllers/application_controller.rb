class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :set_notifications, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  # def set_notifications
  #   notifications = Notification.includes(:recipient).where(recipient: current_user).order(created_at: :desc).limit(10)
  #   @unread = notifications.unread
  #   @read = notifications.read
  # end
end
