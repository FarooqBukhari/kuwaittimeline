class SessionsController < ApplicationController
  def new
    if cookies.signed[:user_id].present?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by(email: email)
    if user.present? && user.valid_password?(password)
      cookies.signed[:user_id] = user.id
      cookies.signed[:admin] = true
      redirect_to root_path
    else
      redirect_to login_path
    end
  end
end
