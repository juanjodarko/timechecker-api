class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    pp request.headers.inspect
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
