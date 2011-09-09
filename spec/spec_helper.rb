require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
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
    config.include Devise::TestHelpers, :type => :view
    config.extend ControllerMacros, :type => :controller

    config.before(:each, :type => :model) do
          stub_user_moc_save
      end

    #Omniauth Mock
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
             'provider' => 'facebook',
             'uid' => '12345',
             'user_info' => {'name' => "Joe Smith", 'nickname' => 'joesmith'},
             'extra' => {'user_hash' => {'email' => "sample@example.com"}},
             'credentials' => {'token' => 'abc123', 'secret' => 'xyz987'}}
    OmniAuth.config.mock_auth[:linked_in] = {
             'provider' => 'linked_in',
             'uid' => '12345',
             'user_info' => {'name' => "Joe Smith", 'nickname' => 'joesmith'},
             'credentials' => {'token' => 'abc123', 'secret' => 'xyz987'}}
    OmniAuth.config.mock_auth[:twitter] = {
             'provider' => 'twitter',
             'uid' => '12345',
             'user_info' => {'name' => "Joe Smith", 'nickname' => 'joesmith'},
             'credentials' => {'token' => 'abc123', 'secret' => 'xyz987'}}
end

Spork.each_run do
  # This code will be run each time you run your specs.

  require 'factory_girl_rails'
  require 'simplecov'
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end

end

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.




# This file is copied to spec/ when you run 'rails generate rspec:install'


def fixture_path
  File.expand_path('../fixtures', __FILE__)
end


def fixture(file)
  File.new(fixture_path + '/' + file)
end

def stub_user_moc_save
  stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
    to_return(:status => 200, :body => fixture("futures_11b.json"))
end

end
