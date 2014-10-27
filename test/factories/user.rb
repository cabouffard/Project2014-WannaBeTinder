FactoryGirl.define do
  factory :user, class: "User" do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email}
    profession { User::PROFESSIONS.sample }
    password { "password123@" }
    confirmed_at { DateTime.now }
    latitude { Fake::Address.latitude }
    longitude { Fake::Address.longitude }
  end
end


