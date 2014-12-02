class Api::V1::BaseApiController < ActionController::Base
  skip_before_filter :authenticate_user!
  # before_filter :validate_token
  # acts_as_token_authentication_handler_for User

  protect_from_forgery with: :null_session

  respond_to :json
  # skip_before_filter :verify_authenticity_token, if: :json_request?

  private

  def json_request?
    request.format.json?
  end

  def validate_token
   user = User.find_for_database_authentication(email: request.headers['X-User-Email'])

   if user && user.authentication_token == request.headers['X-User-Token']
      sign_in user
      render json: current_user.name
   else
     render json: { error: "Login crendentials failed" }, status: :unauthorized
   end
  end
end

