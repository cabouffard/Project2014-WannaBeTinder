class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def update
    sanitizer = devise_parameter_sanitizer.sanitize(:account_update)
    if self.resource.update_attributes(sanitizer)
      flash[:success] = t("users.success_update")
      redirect_to root_url
    else
      flash.now[:alert] = t("simple_form.error_notification.default_message")
      render :edit
    end
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_url
  end

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

  def build_resource(hash = {})
    super
    self.resource = User.new
    self.resource.locale = I18n.locale

    self.resource.assign_attributes(hash || {})
  end

  def after_sign_up_path_for(resource)
      root_url
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
