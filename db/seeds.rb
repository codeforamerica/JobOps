
puts "Add Industry Data"
[
  {:name => "Accommodation and Food Services"},
  {:name => "Administrative and Support Services"},
  {:name => "Agriculture, Forestry, Fishing, and Hunting"},
  {:name => "Arts, Entertainment, and Recreation"},
  {:name => "Construction"},
  {:name => "Educational Services"},
  {:name => "Finance and Insurance"},
  {:name => "Government"},
  {:name => "Health Care and Social Assistance"},
  {:name => "Information"},
  {:name => "Management of Companies and Enterprises"},
  {:name => "Manufacturing"},
  {:name => "Mining, Quarrying, and Oil and Gas Extraction"},
  {:name => "Other Services (Except Public Administration)"},
  {:name => "Professional, Scientific, and Technical Services"},
  {:name => "Real Estate and Rental and Leasing"},
  {:name => "Retail Trade"},
  {:name => "Self-Employed"},
  {:name => "Transportation and Warehousing"},
  {:name => "Utilities"},
  {:name => "Wholesale Trade"},
].each do |attributes|
  Industry.find_or_create_by_name(attributes)
end

if Rails.env != 'production'


require 'faker'
require 'factory_girl_rails'
require 'WebMock'

def fixture_path
  File.expand_path('../../spec/fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end



  WebMock.stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
    to_return(:status => 200, :body => fixture("futures_11b.json"))
  WebMock.stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
     with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
     to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})

  @location = Factory(:location, :location => "San Francisco, CA")

  puts "adding 20 users"
  20.times {
    user = Factory(:user)
    puts "Added #{user.email}"
    }

  puts "adding job searches for 11b and ruby"
  moc_search = Factory(:job_search, :keyword => "11b", :location => @location.location, :search_params =>{"date_acquired_greater_than"=>"", "job_searches_keyword_contains"=>"21b", "job_searches_location_contains"=>"San Francisco, CA", "title_contains"=>"", "company_name_contains"=>""})
  ruby_search = Factory(:job_search, :keyword => "ruby", :location => @location.location, :search_params => {"date_acquired_greater_than"=>"", "job_searches_keyword_contains"=>"21b", "job_searches_location_contains"=>"San Francisco, CA", "title_contains"=>"", "company_name_contains"=>""})

  puts "adding jobs to job searches"
  JobSearch.all.each { |search| 100.times {search.jobs << Factory(:job, :location => @location, :company => Factory(:company, :location => @location.location), :job_source => ["Indeed", "Direct_Employers"].shuffle[0], :date_acquired => Time.at(Time.local(2010,1,1) + rand * (Time.now - Time.local(2011,12,31))))}
  }

  career = Factory(:career)

  puts "flagging jobs"
  User.all.each { |user|  user.jobs << Job.all.shuffle[0..10]}

  puts "flagging careers"
  User.all.each { |user| user.careers << Career.all.shuffle[0..10]}


end
