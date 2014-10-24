class LocationController < ApplicationController
  def evaluate_location
    @location = Geocoder.search("#{location_params[:latitude]},#{location_params[:longitude]}").first
    @user = current_user
    @user.street = @location.address
    @user.city = @location.city
    @user.state = @location.state
    @user.country = @location.country
    @user.latitude = @location.longitude
    @user.longitude = @location.latitude
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end

