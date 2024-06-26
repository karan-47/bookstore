class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:alert] = "Invalid email or credentials"
      render "new"
    end

  end

  def destroy

    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out successfully"
  end

  def new
  end
end
