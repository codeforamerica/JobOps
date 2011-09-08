
if Rails.env != 'production'

  100.times do |i|
    Job.create(:company => Faker::Company.name,
      :date_acquired => Time.at(Time.local(2011,1,1) + rand * (Time.now - Time.local(2011,12,31))),
      :location => Faker::Address.city,
      :title => Faker::Company.catch_phrase,
      :url => Faker::Internet.domain_name)
  end

end
