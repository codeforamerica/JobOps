FactoryGirl.define do
  factory :job_searches do
    keyword "ruby"
    location "San Francisco, CA"
    lat 34.156788991
    long 118.1230984
    user_id 1
    user_saved true
  end
end
