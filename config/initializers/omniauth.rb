Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :linked_in, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  {:scope => 'user_birthday, user_education_history,user_location,user_work_history,offline_access,email'}
end
