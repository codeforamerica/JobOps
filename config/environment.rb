# Load the rails application
require File.expand_path('../application', __FILE__)

# Load heroku vars from local file
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
if Rails.env.developemnt?
  load(heroku_env) if File.exists?(heroku_env)
end

# Initialize the rails application
JobOps::Application.initialize!
