require 'factory_girl'
require 'faker'

10.times do
  user = FactoryGirl.build(:user)
  user.save()
  user.where(user_id: user.id, sector_id: user.id).first_or_create
end

