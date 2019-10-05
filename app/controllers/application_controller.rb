class ApplicationController < ActionController::Base
  NotAuthorized = Class.new(StandardError)

  before_action :authenticate

  rescue_from ApplicationController::NotAuthorized do |exception|
    render json: { errors: [ message: "401 NotAuthorized"] }, status: :unauthorized
  end

  def logged_in?
    !!current_user
  end

  def current_user
    if auth_present?
      user = User.find_by(id: auth["user"])

      if user
        @current_user ||= user
      end
    end
  end

  def authenticate
    unless logged_in?
      render json: { error: "unauthorized" }, status: 401
    end
  end

  private

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer(.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    !!request.env.fetch("HTTP_AUTHORIZATION", "") { |token| token.scan(/Bearer/).flatten.first }
  end
end
