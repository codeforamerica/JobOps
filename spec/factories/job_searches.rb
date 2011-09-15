FactoryGirl.define do
  factory :job_search do
    keyword "ruby"
    location "San Francisco, CA"
    lat 34.156788991
    long 118.1230984
    user_saved true
    search_params {{"date_acquired_greater_than"=>"", "job_searches_keyword_contains"=>"21b", "job_searches_location_contains"=>"San Francisco, CA", "title_contains"=>"", "company_name_contains"=>""}}

  end
end
