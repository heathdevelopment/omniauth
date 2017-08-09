class Token < ApplicationRecord
require 'net/http'
require 'json'
 
class Token < ActiveRecord::Base
 
    # Converts the token’s attributes into a hash with the key names that the 
    # Google API expects for a token refresh
  def to_params
    {
    'refresh_token' => refresh_token,
    'client_id' => ENV['GOOGLE_CLIENT_ID'],
    'client_secret' => ENV['GOOGLE_SECRET'],
    'grant_type' => 'refresh_token'
    }
  end
 
    # Makes a http POST request to the Google API OAuth 2.0 authorization endpoint 
    # using parameters from above
    
    # Google returns JSON data that includes an access token good 
    # for another 60 minutes
  def request_token_from_google
    url = URI("https://accounts.google.com/o/oauth2/token")
    Net::HTTP.post_form(url, self.to_params)
  end
    
    # Requests the token from Google, parses its JSON response and updates your database
    # with the new access token and expiration date. 
  def refresh!
    response = request_token_from_google
    data = JSON.parse(response.body)
    update_attributes(
    access_token: data['access_token'],
    expires_at: Time.now + (data['expires_in'].to_i).seconds)
  end
 
    # returns true if token has expired
  def expired?
    expires_at < Time.now
  end
 
  def fresh_token
    refresh! if expired?
    access_token
  end
 
end

end
