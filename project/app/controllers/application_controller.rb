class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  attr_reader :current_user

  include ExceptionHandler

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
