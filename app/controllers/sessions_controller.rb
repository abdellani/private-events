class SessionsController < ApplicationController
  def new
  end
  def create
    @user = User.find_by_name(params[:session][:name])
    if @user && @user.authenticate( params[:session][:password])
      session[:user_id]=@user.id
      redirect_to user_path @user
    else
      redirect_to login_path
    end
  end
  def destroy
    session.delete(:user_id)
    current_user= nil
    redirect_to login_path
  end
end
