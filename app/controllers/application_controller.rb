# Base controller for app
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = 'You aren\'t allowed to view that page!'
    if current_user
      redirect_to after_sign_in_path_for(current_user)
    else
      redirect_to root_url
    end
  end

  def after_sign_in_path_for(user)
    if user.staff?
      staff_dashboard_path
    else
      student_dashboard_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:login, :email, :password, :password_confirmation)
    end
  end
end
