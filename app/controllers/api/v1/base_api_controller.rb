class Api::V1::BaseApiController < ActionController::Base
  before_filter :validate_token

  protect_from_forgery with: :null_session

  respond_to :json

  private

  def json_request?
    request.format.json?
  end

  def validate_token
   user = User.find_for_database_authentication(email: request.headers['X-User-Email'])

   if user && user.authentication_token == request.headers['X-User-Token']
      sign_in(user)
      @current_user = user
   else
     render json: { error: "Login crendentials failed" }, status: :unauthorized
   end
  end
end

