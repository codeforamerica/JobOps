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
      when 'linked_in'
        self.apply_linked_in(omniauth)
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

  def facebook_user(user_id)
    if not Authentication.where(:provider => "facebook", :user_id => user_id).first.nil?
      facebook_client(user_id)
    end
  end

  def add_facebook_info(user_id)
    @fb_info = facebook_user(user_id).fetch

    #Pull in basic profile information
    self.location = @fb_info.location.name
    self.dob = @fb_info.birthday
    self.gender = @fb_info.gender

    #Pull work history
    @work = @fb_info.work
    @work.each do |work|
      job_history = User.find(user_id).job_histories.new
      job_history.org_name = work.employer.name
      job_history.title = work.position.name
      job_history.summary = work.description
      job_history.start_date = work.start_date
      job_history.end_date = work.end_date
      job_history.save
    end

    #Pull education history
    @education = @fb_info.education
    @education.each do |edu|
      education = User.find(user_id).educations.new
      education.school_name = edu.school.name
      education.degree = edu.degree.name if edu.degree
      education.study_field = edu.concentration.first.name if !edu.concentration.empty?
      education.end_date = Date.parse("1-1-" + edu.year.name)
      education.save
    end
  end

  def linked_in_user
    unless authentications.where(:provider => "linked_in").first.nil?
      linked_in_client
    end
  end

  def add_linked_in_info
    @linked_in_profile = linked_in_client.profile

    #Pull work history
    @work = @linked_in_profile.positions
    @work.each do |work|
      job_history = job_histories.new
      job_history.org_name = work.company.name
      job_history.title = work.title
      job_history.summary = work.summary
      job_history.start_date = Date.new(work.start_year,work.start_month,1)
      unless work.end_year == 0
        job_history.end_date = Date.new(work.end_year,work.end_month,1)
      end
        job_history.save
    end

  end

  def twitter_user(user_id)
    if not Authentication.where(:provider => "twitter", :user_id => user_id).first.nil?
      twitter_client(user_id)
    end
  end

  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
      self.password = Devise.friendly_token[0,20]
    end
  end

  def facebook_client(user_id)
    facebook_authentication = Authentication.where(:provider => "facebook", :user_id => user_id).first.access_token
    facebook_client ||= FbGraph::User.me(facebook_authentication)
  end

  def apply_linked_in(omniauth)
    #Create a fake email address using LinkedIn uid
    self.email = "#{omniauth['uid']}@jobops.us"
    self.password = Devise.friendly_token[0,20]
  end

  def linked_in_client
    linked_in_auth = authentications.where(:provider => "linked_in").first
    LinkedIn.configure do |config|
      config.token = ENV['LINKEDIN_KEY']
      config.secret = ENV['LINKEDIN_SECRET']
      config.default_profile_fields = ['certifications','date-of-birth','educations',
        'positions','picture-url','skills','summary']
    end
    linked_in = LinkedIn::Client.new
    linked_in.authorize_from_access(linked_in_auth.access_token, linked_in_auth.access_secret)
    linked_in_client ||= linked_in

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


end
