class ApplicationController < ActionController::API
  before_action :authenticate 
  
  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find(auth["user"])
  end

  def authenticate
    if !logged_in?
      render json: {error: "unauthorized"}, status: 401 
    end
  end

  private

  def token
    request.authorization.scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end
end
