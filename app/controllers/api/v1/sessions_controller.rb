class Api::V1::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session

  respond_to :json

  acts_as_token_authentication_handler_for User
  skip_before_filter :authenticate_entity_from_token!
  skip_before_filter :authenticate_entity!

  before_filter :authenticate_entity_from_token!, :only => [:destroy]
  before_filter :authenticate_entity!, :only => [:destroy]

  def create
   user = User.find_for_database_authentication(email: user_params[:email])

   if user && user.valid_password?(user_params[:password])
     sign_in user
     render json: user, status: :ok, serializer: PrivateUserSerializer
   else
     render json: { error: "Login crendentials failed" }, status: :unauthorized
   end

    # warden.authenticate(scope: resource_name)
    # if current_user.nil?
    #   render json: { error: "Login crendentials failed" }, status: :unauthorized
    # else
    #   render json: current_user, status: :ok
    # end
  end

  def destroy
    if user_signed_in?
      @user = current_user
      @user.authentication_token = nil
      @user.save
      render json: { message: 'Successfully logged out' }, status: :ok
    else
      render json: { message: 'This user was not logged in' }, status: :ok
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def json_request?
    request.format.json?
  end
end
