FactoryGirl.define do
  factory :location do
    location {Faker::Address.city + ", " + Faker::Address.state_abbr}
    lat 37.775
    long 122.4183333
  end
end
