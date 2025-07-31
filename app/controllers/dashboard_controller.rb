class DashboardController < ApplicationController
  before_action :require_login

  def index
    # code để hiển thị dashboard
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "You must log in first."
    end
  end
end
