class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid
end
