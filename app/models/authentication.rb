class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid, :access_token, :access_secret

  belongs_to :user

  scope :facebook, where(:provider => 'facebook')
  scope :linked_in, where(:provider => 'linked_in')
  scope :twitter, where(:provider => 'twitter')
end

