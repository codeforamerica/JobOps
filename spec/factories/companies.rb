FactoryGirl.define do
  factory :company do
    name {Faker::Company.name + rand(100).to_s}
    location {Faker::Address.city + ", " + Faker::Address.state_abbr}
    linkedin_id 660862
  end
end
