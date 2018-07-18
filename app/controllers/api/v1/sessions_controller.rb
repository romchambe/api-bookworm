module Api::V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate
    
    def create
      puts request
      return render json: {message:'This user does not exist', status: :bad_request} unless user = User.find_by(email: auth_params[:email])
      
      if user.authenticate(auth_params[:password])
        jwt = Auth.issue({user: user.id})
        render json: {jwt: jwt, username: user.username}
      else
        render json: {message:'The password provided is incorrect', status: :bad_request}
      end

    end

    def auth_params
      params.require(:auth).permit(:email, :password, :remember_me)
    end
  end
end 
