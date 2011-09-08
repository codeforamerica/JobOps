
if Rails.env != 'production'

  100.times do |i|
    Location.create(:location => Faker::Address.city)
  end

  100.times do |i|
    Company.create(:name => Faker::Company.name, :location => Faker::Address.city)
  end

  100.times do |i|
    Job.create(:company_id => i ,
      :date_acquired => Time.at(Time.local(2011,1,1) + rand * (Time.now - Time.local(2011,12,31))),
      :location_id => i ,
      :title => Faker::Company.catch_phrase,
      :url => Faker::Internet.domain_name)
  end

end
