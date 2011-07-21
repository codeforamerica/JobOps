class Certification < ActiveRecord::Base
  belongs_to :user
  has_one :user
end
