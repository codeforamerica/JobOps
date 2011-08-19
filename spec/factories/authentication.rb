FactoryGirl.define do
  factory :authentication do
    user_id 1
    provider "twitter"
    uid "12345"
    access_token "abc123"
    access_secret "xyz987"
  end
end

