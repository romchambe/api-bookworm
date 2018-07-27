module Api::V1
  class RegistrationsController < ApplicationController
    skip_before_action :validate_token
    
    def create
      user = User.new(registration_params)
      if user.save 
        jwt = Auth.issue({user: user.id})
        render json: {jwt: jwt, user: {email:user.email, id:user.id}}
      else 
        render json: user.errors.full_messages
      end
    end

    def delete
    end

    def registration_params
      params.require(:registration).permit(:email, :password, :password_confirmation)
    end
  end
end 