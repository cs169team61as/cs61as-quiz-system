# Base controller for app
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  [MCQuestion, CodeboxQuestion, TextboxQuestion,
   CheckboxQuestion] if Rails.env == 'development'

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
end
