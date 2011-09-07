FactoryGirl.define do
  factory :company do
    name {Faker::Company.name}
    location {Factory(:location)}
    linked_in 660862
  end
end
