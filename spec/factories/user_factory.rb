Factory.define(:user) do |u|
  u.sequence(:email) {|n| "email#{n}@testcompany.com"}
  u.password "123456"
  u.password_confirmation "123456"
  u.first_name "GI"
  u.last_name "Joe"
  u.service_branch "Coast Gaurd"
  u.moc "10A"
  u.rank "E220"
  u.disability "n/a"
  u.security_clearance "No Clerances"
  u.resume "This is my Resume"
  u.email_settings ["dinosaurs", "lasers"]
end
