Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"],{
      name: 'google',
      scope: 'email, profile',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50
      }
    
    OmniAuth.config.on_failure = Proc.new do |env|
        SessionsController.action(:auth_failure).call(env)
    end
end