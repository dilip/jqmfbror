require 'authorization'
require 'multi_json'
require 'uri'
class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user

    fb_user = FbUser.new(nil) # When logging in, we don't have access token. So pass nil.
    fb_user.init_access_token(params["code"])
    session["facebook_access_token"] = fb_user.access_token
    #friend_list = fb_user.get_friend_list()
    #puts friend_list
 
    #render :text => "Welcome, #{current_user.name}." + request.env['rack.auth'].inspect
    muser = self.current_user
    redirect_to :controller => :friends, :action => :index
  end

  def destroy
    reset_session
    redirect_to :controller => :welcome
  end
end

