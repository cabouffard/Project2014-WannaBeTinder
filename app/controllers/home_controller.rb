class HomeController < PublicController
  def redirect_or_index
    if user_signed_in?
      if current_user.sign_in_count == 1 && !current_user.has_location?
        if current_user.current_sign_in_ip == "127.0.0.1"
          current_user.city = "Sherbrooke"
          current_user.country = "Canada"
          current_user.state = "Québec"
          current_user.save
        else
          location = request.location
          current_user.city = location.city
          current_user.country = location.country
          current_user.state = location.state
          current_user.save
        end
      end
      redirect_to search_path
    else
      render :index, status: :found, location: url_for(controller: :home, action: :index, locale: browser_locale)
    end
  end

  def index
  end
end

