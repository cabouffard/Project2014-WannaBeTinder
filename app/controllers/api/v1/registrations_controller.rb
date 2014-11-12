class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_filter :verify_authenticity_token, if: :json_request?

  acts_as_token_authentication_handler_for User
  skip_before_filter :authenticate_entity_from_token!, only: [ :create ]
  skip_before_filter :authenticate_entity!, only: [ :create ]

  skip_before_filter :authenticate_scope!
  append_before_filter :authenticate_scope!, only: [ :destroy ]

  def create
    build_resource
    if self.resource.update_attributes(user_params)
      render nothing: true, status: :ok
    else
      clean_up_passwords resource
      render json: { error: resource.errors }, status: :error
    end
  end

  protected

  def build_resource(hash = {})
    super
    self.resource = User.new

    self.resource.assign_attributes(hash || {})
  end

  private

  def user_params
    params.require(:user).permit(:profession, :email, :password,
                                    :password_confirmation, :first_name,
                                    :last_name)
  end

  def json_request?
    request.format.json?
  end
end
