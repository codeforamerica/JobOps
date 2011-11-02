source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

# Asset template engines
group :assets do
  gem 'sass-rails'
  gem 'coffee-script'
  gem 'uglifier'
end

gem 'active_link_to'
gem 'aws-s3'
gem 'devise'
gem 'direct_employers'
gem 'futures_pipeline'
gem 'gravatar_image_tag'
gem 'haml'
gem 'indeed'
gem 'jquery-rails'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem 'geocoder'
gem 'will_paginate'
gem 'meta_search'
gem 'places'
gem 'delayed_job'
gem 'redirect_follower'

gem 'fb_graph'
gem 'linkedin'
gem 'twitter', '~> 2.0.0.rc.1'

platforms :jruby do
  gem 'jruby-openssl'
  gem 'therubyrhino'
end

group :development do
  gem 'ZenTest'
end

group :development, :test do
  gem 'faker'
  gem 'activerecord-spatialite-adapter'
  gem 'nifty-generators'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'sqlite3'
  gem 'spork', '0.9.0.rc9'
end

group :test do
  gem 'factory_girl_rails'
  gem 'mocha'
  gem 'webmock'
  gem 'webrat'
end

group :production do
  gem 'pg'
  gem 'thin'
end
