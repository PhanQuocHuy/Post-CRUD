class SessionsController < ApplicationController
  def new
    redirect_to posts_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to posts_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You have logged out successfully."
  end
end
