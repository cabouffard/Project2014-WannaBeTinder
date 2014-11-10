require 'factory_girl'
require 'faker'

10.times do |i|
  if !User.where(email: "fakeuser_#{i}@gmail.com").exists?
    location = Geocoder.search(Faker::Internet.ip_v4_address).first
    user = FactoryGirl.build(:user,
                             latitude: location.latitude,
                             longitude: location.longitude)
    user.email = "fakeuser_#{i}@gmail.com"
    user.save()
  end
end

