require 'json'
# Models a Facebook user.  Has methods to invoke different Facebook APIs.
class FbUser
    attr_reader :access_token

    include  HTTParty
    base_uri "https://graph.facebook.com"

    # When logging in (session_controller), nil is passed as the access token
    # and init_access_token() is called to obtain an access token from FB.
    # In other controllers, this object is initialized with the access token
    # stored in the session object.
    def initialize(access_token)
        @app_id = Rails.application.config.facebook_app_id
        @app_secret = Rails.application.config.facebook_app_secret
        @redirect_uri = Rails.application.config.facebook_redirect_uri
        @access_token = access_token
    end

    def init_access_token(auth_code)
        response = self.class.get('/oauth/access_token', 
                :query => {
                        "client_id" => @app_id,
                        "client_secret" => @app_secret,
                        "code" => auth_code,
                        "redirect_uri" => @redirect_uri
                           }
            )
        @access_token = CGI::parse(response.body)["access_token"][0]
        puts "Access Token = " + @access_token
    end

    def get_friend_list()
        response = self.class.get('/me/friends', 
                :query => {
                            "access_token" => @access_token
                           }
            )
        return JSON.parse(response.body)["data"]
    end
end
