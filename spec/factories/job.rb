FactoryGirl.define do
  factory :job do
    company {Factory(:company)}
    date_acquired Date.new(2011,1,1)
    location {Factory(:location)}
    snippet {Faker::Lorem.sentence}
    title {Faker::Lorem.sentence + rand(100).to_s}
    url {"http://" + Faker::Internet.domain_suffix}
  end
end
