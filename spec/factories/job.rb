FactoryGirl.define do
  factory :job do
    company {Factory(:company)}
    date_acquired Date.new(2011,1,1)
    location {Faker::Address.city}
    title {Faker::Lorem.sentence}
    url {"http://" + Faker::Internet.domain_suffix}
  end
end
