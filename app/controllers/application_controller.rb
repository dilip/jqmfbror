require 'active_support/values/time_zone.rb'
require 'muser'

class ApplicationController < ActionController::Base
  protect_from_forgery

  def reset_session1
    reset_session
    @current_user = nil
  end

  protected

  def current_user
    if session[:user_id].nil?
      return nil
    end
    @current_user ||= MUser.find_by_id(BSON::ObjectId(session[:user_id]))
  end

  def signed_in?
    if session[:user_id].nil?
      return false
    end
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user["_id"].to_s
  end

end

