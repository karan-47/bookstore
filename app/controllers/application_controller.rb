class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authorized
  helper_method :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authorized
    redirect_to root_path unless logged_in?
  end

  def logged_in?
    !current_user.nil?
  end

  def is_admin?
    if @current_user.nil?
      false
    elsif @current_user.email=="admin@gmail.com"
      true
    else
      false
    end
  end

end
