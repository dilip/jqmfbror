Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, Rails.application.config.facebook_app_id, Rails.application.config.facebook_app_secret, {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}, :display => "touch"}
end

