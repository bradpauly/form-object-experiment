class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def start_session(user)
    session[:user_id] = user.id
  end

  def destroy_session
    reset_session
  end
end
