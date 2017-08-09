class SessionsController < ApplicationController
    def new
    end

    def create
      @auth = request.env['omniauth.auth']['credentials']
      Token.create(
            access_token: @auth['token'],
            refresh_token: @auth['refresh_token'],
            email: @auth['email'],
            expires_at: Time.at(@auth['expires_at']).to_datetime) 
    end
    
    def destroy
        if current_user
            session.delete(:user_id)
            flash[:success] = 'See you!'
        end
            redirect_to root_path
    end
    
    def auth_failure
        redirect_to root_path
    end
end
