class HomeController < PublicController
  def redirect_or_index
    if user_signed_in?
      render :show
    else
      render :index, status: :found, location: url_for(controller: :home, action: :index, locale: browser_locale)
    end
  end

  def index
  end

  def show
  end
end

