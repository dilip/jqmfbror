class FriendsController < ApplicationController
    def index
        @user = current_user
        fb_user= FbUser.new(session["facebook_access_token"])
        # The access token is embedded in the generated HTML page
        # for use by client-side javascript to access facebook.
        @fb_access_token = fb_user.access_token
    end
end
