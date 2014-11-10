class HomeController < PublicController
  def redirect_or_index
    if user_signed_in?
      if current_user.sign_in_count == 1 && !current_user.has_gps_location?
        if current_user.current_sign_in_ip == "127.0.0.1"
          current_user.latitude = "45.378659"
          current_user.longitude = "-71.9309023"
        else
          location = Geocoder.search(current_user.current_sign_in_ip).first
          current_user.latitude = location.latitude
          current_user.longitude = location.longitude
        end
        current_user.save
      end
      redirect_to search_path
    else
      render :index, status: :found, location: url_for(controller: :home, action: :index, locale: browser_locale)
    end
  end

  def index
  end
end

