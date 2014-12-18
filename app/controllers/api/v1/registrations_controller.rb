class Api::V1::RegistrationsController < Devise::RegistrationsController
  require 'cgi'
  before_filter :validate_token, only: [:update]
  protect_from_forgery with: :null_session
  respond_to :json

  # skip_before_filter :verify_authenticity_token, if: :json_request?

  # acts_as_token_authentication_handler_for User
  # skip_before_filter :authenticate_entity_from_token!, only: [ :create ]
  # skip_before_filter :authenticate_entity!, only: [ :create ]

  skip_before_filter :authenticate_scope!
  # append_before_filter :authenticate_scope!, only: [ :destroy ]

  def create
    build_resource
    if self.resource.update_attributes(user_params)
      render nothing: true, status: :ok
    else
      clean_up_passwords resource
      render json: { error: resource.errors }, status: :error
    end
  end

  def update
    if @user.update_attributes(account_update)
      render json: { message: "Account information has been succesfully updated!" }, status: :ok
    else
      render json: { error: "Unable to modified account informations" }, status: :error
    end
  end

  protected

  def build_resource(hash = {})
    super
    self.resource = User.new

    self.resource.assign_attributes(hash || {})
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:picture, :picture_cache, :latitude, :longitude, :profession,
               :email, :first_name, :last_name, :street, :city, :state,
               :country, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:profession, :email, :password, :password_confirmation,
               :first_name, :last_name)
    end
  end

  def user_params
    params.require(:user).permit(:profession, :email, :password,
                                    :password_confirmation, :first_name,
                                    :last_name)
  end

  def account_update
    params.require(:user).permit(:profession, :first_name, :last_name,
                                    :street, :state, :country, :city)
  end

  def json_request?
    request.format.json?
  end

  def validate_token
   user = User.find_for_database_authentication(email: request.headers['X-User-Email'])

   if user && user.authentication_token == request.headers['X-User-Token']
      sign_in(user)
      @user = user
   else
    render json: { error: "Login crendentials failed" }, status: :unauthorized if @user == nil
   end
  end

end
