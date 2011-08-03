class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name,
                  :last_name, :city, :state, :goal, :relocate, :desired_salary, :gender,
                  :ethnicity, :family, :dob, :military_status, :service_branch, :moc,
                  :rank, :disability, :security_clearance, :unit, :resume, :avatar,
                  :privacy_settings, :email_settings

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  serialize :email_settings
  serialize :privacy_settings

  has_many :awards
  has_many :certifications
  has_many :job_histories
  has_many :educations
  has_many :languages
  has_many :skills
  has_many :trainings
  has_many :wars

  def full_name
    self.first_name + ' ' +  self.last_name
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
