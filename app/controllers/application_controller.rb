# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def logged_in?
    current_user != nil
  end

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id]) unless user_id.nil?
  end

  attr_writer :current_user

  private

  def user_logged_in?
    redirect_to login_path unless logged_in?
  end
end
