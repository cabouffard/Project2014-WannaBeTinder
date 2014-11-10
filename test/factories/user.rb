FactoryGirl.define do
  factory :user, class: "User" do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    profession { User.professions.sample }
    password { "password123@" }
    confirmed_at { DateTime.now }
  end
end


