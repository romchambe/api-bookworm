module Api::V2
  class SessionsController < ApplicationController
    skip_before_action :validate_token
    
    def create
      begin
        user = User.find_by!(email: login_params[:email])

        if user.authenticate(login_params[:password])
          jwt = Auth.issue({user: user.id})
          render json: {jwt: jwt, user: { username: user.username, email: user.email, id: user.id}}
        else
          render json: { error: true, message: 'Invalid password' }.to_json, status: :bad_request
        end
        
      rescue ActiveRecord::RecordNotFound => e
        puts e 
        render json: { error: true, message: 'This user does not exist' }.to_json, status: :not_found
      end  
    end

    def fb_create
      user = User.find_by(email: fb_login_params[:email])

      if user.nil?
        user = User.create(username: fb_login_params[:username], email: fb_login_params[:email], password: fb_login_params[:id], password_confirmation: fb_login_params[:id])
        if !user.valid?
          return render json: {error: true, message:'There was an issue creating the user'}, status: :bad_request
        end
      end

      jwt = Auth.issue({user: user.id})
      render json: {jwt: jwt, user: user.email}
    end
    
    private

    def fb_login_params
      params.require(:login).permit(:email, :name, :id, :picture)
    end

    def login_params
      params.require(:login).permit(:email, :password)
    end
  end
end 
