FactoryGirl.define do
  factory :company do
    name {Faker::Company.name}
    location {Factory(:location)}
    linkedin_id 660862
  end
end
