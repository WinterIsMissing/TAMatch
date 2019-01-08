Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['OAUTH_ID'], ENV['OAUTH_KEY'],
  scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
end
