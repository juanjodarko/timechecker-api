class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    user = User.find_by_email(auth_params[:email]).as_json
    token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response({user: user, token: token})
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
