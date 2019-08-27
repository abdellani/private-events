class SessionsController < ApplicationController
  before_action :prevent_access_login, only: [:new,:create]
  def new
  end
  def create
    @user = User.find_by_name(params[:session][:name])
    if @user && @user.authenticate( params[:session][:password])
      session[:user_id]=@user.id
      redirect_to user_path @user
    else
      flash[:error] = 'Email or password is wrong!'
      redirect_to login_path
    end
  end
  def destroy
    session.delete(:user_id)
    current_user= nil
    redirect_to login_path
  end
  private 
  def prevent_access_login
    redirect_to root_path if logged_in?
  end
end
