class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user,:logged_in?

  def logged_in?
    current_user != nil
  end
  def current_user
    if user_id = session[:user_id]
      @current_user ||=User.find_by(id:session[:user_id])
    else
      nil
    end
  end
  def current_user= user
    @current_user = user
  end
  private

  def is_user_logged_in
    if !logged_in?
      redirect_to login_path
    end
  end

end
