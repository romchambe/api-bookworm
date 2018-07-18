module Api::V1
  class SessionsController < ApplicationController
    skip_before_action :validate_token
    
    def create
      puts login_params
      
      begin
        user = User.find_by!(email: login_params[:email])

        if user.authenticate(login_params[:password])
          jwt = Auth.issue({user: user.id})
          render json: {jwt: jwt, user: user.email}
        else
          render json: {message:'The password provided is incorrect'}, status: :bad_request
        end
        
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.to_s }, status: :not_found
      end
      
    end

    def login_params
      params.require(:login).permit(:email, :password)
    end
  end
end 
