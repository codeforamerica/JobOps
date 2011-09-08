require 'faker'
require 'factory_girl_rails'
require 'WebMock'

def fixture_path
  File.expand_path('../../spec/fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end


if Rails.env != 'production'
  
  WebMock.stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
    to_return(:status => 200, :body => fixture("futures_11b.json"))
  WebMock.stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
     with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
     to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})
  
  puts "adding 20 users"
  20.times {
    user = Factory(:user)
    puts "Added #{user.email}"
    }
  
  
  puts "adding job searches for 11b and ruby"
  moc_search = Factory(:job_search, :keyword => "11b")
  ruby_search = Factory(:job_search, :keyword => "ruby")  
  
  puts "adding moc jobs"
  @location = Factory(:location, :location => "San Francisco, CA")
  100.times {moc_search.jobs << Factory(:job, :location => @location)}
  
  puts "adding ruby jobs"
  100.times {ruby_search.jobs << Factory(:job, :location => @location)}  
  
  puts "flagging jobs"
  User.all.each { |user|  user.jobs << Job.all.shuffle[0..10]}


end
