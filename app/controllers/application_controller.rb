class ApplicationController < ActionController::API
  before_action :validate_token
  
  def logged_in?
    !!current_user
  end

  def current_user
    binding.pry
    if !!request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first && !!(user = User.find_by(id: auth["user"]))
      @current_user ||= user
    end 
  end

  def validate_token
    render json: {error: "unauthorized"}, status: 401 unless logged_in?
  end

  private

  def token
    request.authorization.scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end
end
