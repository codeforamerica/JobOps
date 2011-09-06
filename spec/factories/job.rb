FactoryGirl.define do
  factory :job do
    company "Code for America"
    date_acquired Date.new(2011,1,1)
    location "San Francisco, CA"
    title "Fellow"
    url "http://www.codeforamerica.org"
  end
end
