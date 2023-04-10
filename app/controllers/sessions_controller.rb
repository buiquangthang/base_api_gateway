class SessionsController < ApplicationController
  skip_before_action :authenticate

  def sign_in
    render json: { auth_token: auth_token }, status: :created
  end

  private

  def auth_params
    params.require(:auth).permit :email, :password
  end

  def auth_token
    user = User.find_by(email: auth_params[:email])

    if user&.authenticate(auth_params[:password])
      Auth.issue({ user: user.id })
    else
      raise ApplicationController::NotAuthorized
    end
  end
end
