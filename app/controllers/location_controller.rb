class LocationController < ApplicationController
  def evaluate_location
    @location = Geocoder.search("#{location_params[:latitude]},#{location_params[:longitude]}").first
    @user = current_user
    @user.street = @location.street_address
    @user.city = @location.city
    @user.state = @location.state
    @user.country = @location.country
    @user.latitude = @location.latitude
    @user.longitude = @location.longitude
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end

