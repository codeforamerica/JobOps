# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  #Devise helper
  config.include Devise::TestHelpers, :type => :controller

  config.extend ControllerMacros, :type => :controller

  #Omniauth Mock
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = {
           'provider' => 'twitter',
           'uid' => '12345',
           'user_info' => {'name' => "Joe Smith", 'nickname' => 'joesmith'},
           'credentials' => {'token' => 'abc123', 'secret' => 'xyz987'}
            }
 OmniAuth.config.mock_auth[:facebook] = {
           'provider' => 'facebook',
           'uid' => '12345',
           'user_info' => {'name' => "Joe Smith", 'nickname' => 'joesmith'},
           'extra' => {'user_hash' => {'email' => "sample@example.com"}},
           'credentials' => {'token' => 'abc123', 'secret' => 'xyz987'}
            }

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

end
