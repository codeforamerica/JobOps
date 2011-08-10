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

  if Rails.env  == 'development'
    has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100"}
  elsif Rails.env  == 'production'
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3,
                    :bucket => 'jobops',
                    :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}
  end

  serialize :email_settings
  serialize :privacy_settings

  has_many :awards
  has_many :authentications
  has_many :certifications
  has_many :job_histories
  has_many :educations
  has_many :languages
  has_many :skills
  has_many :trainings
  has_many :wars

  validates_presence_of :first_name, :last_name

  def apply_omniauth(omniauth)
    case omniauth['provider']
      when 'facebook'
        self.apply_facebook(omniauth)
      end
    self.email = omniauth['user_info']['email'] if email.blank?
    build_authentications(omniauth, save_it)
  end

  def build_authentications(omniauth, save_it = false)
    auth_params = {:provider => omniauth['provider'], :uid => omniauth['uid'], :token =>(omniauth['credentials']['token'] rescue nil)}
    if save_it
      authentications.create!(auth_params)
    else
      authentications.build(auth_params)
    end
  end

  def apply_omniauth!(omniauth)
    apply_omniauth(omniauth, true)
  end


  def password_required?
    (authentications.empty? || !password.blank?) && super
  end


  def full_name
    self.first_name + ' ' +  self.last_name
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
