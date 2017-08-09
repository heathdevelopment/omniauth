Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,  ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET'],{
    scope: ['email',
    'https://www.googleapis.com/auth/gmail.modify'],
    access_type: 'offline'}
    
    OmniAuth.config.on_failure = Proc.new do |env|
        SessionsController.action(:auth_failure).call(env)
    end
end