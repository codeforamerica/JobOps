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
  has_many :job_searches_user
  has_many :job_searches, :through => :job_searches_user
  has_many :job_users
  has_many :jobs, :through => :job_users
  validates_presence_of :name

  before_save :add_saved_search

  def add_saved_search
    if self.moc_changed?
      if !self.moc.blank?
        if self.location?
          job_search = JobSearch.where(:keyword => self.moc, :location => self.location)
          job_search = JobSearch.create(:keyword => self.moc, :location => self.location, :search_params => {"job_searches_keyword_contains"=> self.moc, "job_searches_location_contains"=> self.location}) unless !job_search.blank?
          job_search.delay(:priority => 10).search
        else
          job_search = JobSearch.where(:keyword => self.moc)
          job_search = JobSearch.create(:keyword => self.moc) unless !job_search.blank?
        end

        if job_search.is_a?(Array)
          job_search.each { |job| job.delay(:priority => 10).search}
        else
        job_search.delay(:priority => 10).search
        end

        self.job_searches << job_search

        careers = Career.new.futures_pipeline
        career_by_moc = careers.search(self.moc)

        unless career_by_moc.nil?
          career_by_moc.each do |career|
            if self.location?
              job_search = JobSearch.where(:keyword => career.title, :location => self.location)
              job_search = JobSearch.create(:keyword => career.title, :location => self.location, :search_params => {"job_searches_keyword_contains"=> career.title, "job_searches_location_contains"=> self.location} ) unless !job_search.blank?
            else
              job_search = JobSearch.where(:keyword => career.title)
              job_search = JobSearch.create(:keyword => career.title) unless !job_search.blank?
            end
            self.job_searches << job_search
            if job_search.is_a?(Array)
              job_search.each { |job| job.delay(:priority => 10).search}
            else
            job_search.delay(:priority => 10).search
            end
          end
        end
      end
    end
  end

  def apply_omniauth(omniauth, save_it = false)
    if omniauth['user_info']
      self.name = omniauth['user_info']['name'] if omniauth['user_info']['name']
      self.location = omniauth['user_info']['location'] if omniauth['user_info']['location']
    end
    case omniauth['provider']
      when 'facebook'
        self.apply_facebook(omniauth)
      when 'linked_in'
        self.apply_email(omniauth)
      when 'twitter'
        self.apply_email(omniauth)
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

  def age(dob, now = Time.now.utc.to_date)
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def twitter_user
    unless authentications.where(:provider => "twitter").first.nil?
      twitter_client
    end
  end

  def facebook_user
    unless authentications.where(:provider => "facebook").first.nil?
      facebook_client
    end
  end

  def add_facebook_info
    @fb_info = facebook_user.fetch

    #Pull in basic profile information
    self.location = @fb_info.location.name if @fb_info.location
    self.dob = @fb_info.birthday if @fb_info.birthday
    self.gender = @fb_info.gender

    #Pull work history
    @work = @fb_info.work
    @work.each do |work|
      job_history = job_histories.new
      job_history.org_name = work.employer.name
      job_history.title = work.position.name if work.position
      job_history.summary = work.description if work.description
      job_history.start_date = work.start_date if work.start_date
      job_history.end_date = work.end_date if work.end_date
      job_history.save
    end

    #Pull education history
    @education = @fb_info.education
    @education.each do |edu|
      education = educations.new
      education.school_name = edu.school.name
      education.degree = edu.degree.name if edu.degree
      education.study_field = edu.concentration.first.name if !edu.concentration.empty?
      education.end_date = Date.new(edu.year.name.to_i) if edu.year
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

    #Basic Information
    self.phone = @linked_in_profile.phone_numbers.first.phone_number if !@linked_in_profile.phone_numbers.empty?

    if @linked_in_profile.birthdate.day == 0
      self.dob = nil
    else
      self.dob = Date.new(@linked_in_profile.birthdate.year,
                        @linked_in_profile.birthdate.month,
                        @linked_in_profile.birthdate.day)
    end

    #Pull work history
    @work = @linked_in_profile.positions
    @work.each do |work|
      job_history = job_histories.new
      job_history.org_name = work.company.name
      job_history.title = work.title
      job_history.summary = work.summary
      job_history.start_date = Date.new(work.start_year,work.start_month)
      unless work.end_year == 0
        job_history.end_date = Date.new(work.end_year,work.end_month)
      end
      job_history.save
    end

    #Pull Education history
    @education = @linked_in_profile.educations
    @education.each do |edu|
      education = educations.new
      education.school_name = edu.school_name
      education.degree = edu.degree
      education.study_field = edu.field_of_study
      education.start_date = Date.new(edu.start_year)
      education.end_date = Date.new(edu.end_year)
      education.activities = edu.activities
      education.notes = edu.notes
      education.save
    end

    #Pull Certifications
    @cert = @linked_in_profile.certifications
    @cert.each do |certification|
      cert = certifications.new
      cert.name = certification.name
      cert.save
    end

    #Pull Languages
    @language = @linked_in_profile.languages
    @language.each do |linked_in_language|
      language = languages.new
      language.language = linked_in_language.name
      language.save
    end

    #Pull Skills
    @skill = @linked_in_profile.skills
    @skill.each do |linked_in_skill|
      user_skill = skills.new
      user_skill.skill = linked_in_skill.name
      user_skill.save
    end
  end

  def twitter_user
    if not authentications.where(:provider => "twitter").first.nil?
      twitter_client
    end
  end

  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
      self.password = Devise.friendly_token[0,20]
    end
  end

  def apply_email(omniauth)
    #Create a fake email address using LinkedIn uid
    self.email = "change-me-#{omniauth['uid']}@jobops.us"
    self.password = Devise.friendly_token[0,20]
  end

  def linked_in_client
    linked_in_auth = authentications.where(:provider => "linked_in").first
    LinkedIn.configure do |config|
      config.token = ENV['LINKEDIN_KEY']
      config.secret = ENV['LINKEDIN_SECRET']
      config.default_profile_fields = ['certifications','date-of-birth','educations',
        'phone-numbers','positions','picture-url','skills','summary']
    end
    linked_in = LinkedIn::Client.new
    linked_in.authorize_from_access(linked_in_auth.access_token, linked_in_auth.access_secret)
    linked_in_client ||= linked_in
  end

  def twitter_client
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = authentications.where(:provider => "twitter").first.access_token
      config.oauth_token_secret = authentications.where(:provider => "twitter").first.access_secret
    end
    twitter_client ||= Twitter::Client.new
  end

  def facebook_client
    facebook_authentication = authentications.where(:provider => "facebook").first.access_token
    facebook_client ||= FbGraph::User.me(facebook_authentication)
  end

end
