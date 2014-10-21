class PublicController < ApplicationController
  skip_before_filter :authenticate_user!
  layout "public"

  def set_locale
    I18n.locale = params_locale || cookies.signed[:locale] || browser_locale
  end

  def params_locale
    case params[:locale]
    when "fr"
      locale = :fr
    when "en"
      locale = :en
    end

    if I18n.available_locales.include?(locale)
      params[:locale]
    else
      nil
    end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end
end

