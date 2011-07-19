Factory.define(:user) do |u|
  u.sequence(:email) {|n| "email#{n}@testcompany.com"}
  u.password "123456"
  u.password_confirmation "123456"
  u.first_name "GI"
  u.last_name "Joe"
end