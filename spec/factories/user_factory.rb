FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@testcompany.com"}
    password "123456"
    password_confirmation "123456"
    name "GI Joe"
    service_branch "Coast Gaurd"
    moc "11B"
    rank "E220"
    disability "n/a"
    security_clearance "No Clerances"
    resume "This is my Resume"
    email_settings ["dinosaurs", "lasers"]
  end
end

