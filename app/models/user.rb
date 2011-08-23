class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,
                  :location, :phone, :goal, :relocate, :desired_salary, :gender,
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

  validates_presence_of :name

  def apply_omniauth(omniauth, save_it = false)
    if omniauth['user_info']
      self.name = omniauth['user_info']['name'] if omniauth['user_info']['name']
      self.location = omniauth['user_info']['location'] if omniauth['user_info']['location']
    end
    case omniauth['provider']
      when 'facebook'
        self.apply_facebook(omniauth)
      end
    self.email = omniauth['user_info']['email'] if email.blank?
    build_authentications(omniauth, save_it)
  end

  def build_authentications(omniauth, save_it = false)
    auth_params = { :provider => omniauth['provider'],
                    :uid => omniauth['uid'],
                    :access_token => omniauth['credentials']['token'],
                    :access_secret => omniauth['credentials']['secret'],
    }
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

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def twitter_user(user_id)
    if not Authentication.where(:provider => "twitter", :user_id => user_id).first.nil?
      twitter_client(user_id)
    end
  end


  def facebook_user(user_id)
    if not Authentication.where(:provider => "facebook", :user_id => user_id).first.nil?
      facebook_client(user_id)
    end
  end

  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end

  def twitter_client(user_id)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = Authentication.where(:provider => "twitter", :user_id => user_id).first.access_token
      config.oauth_token_secret = Authentication.where(:provider => "twitter", :user_id => user_id).first.access_secret
    end
    twitter_client ||= Twitter::Client.new
  end

  def facebook_client(user_id)
    facebook_authentication = Authentication.where(:provider => "facebook", :user_id => user_id).first.access_token
    facebook_client ||= FbGraph::User.me(facebook_authentication)
  end

end
