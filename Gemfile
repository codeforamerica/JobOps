source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

# Asset template engines
group :assets do
  gem 'sass-rails'
  gem 'coffee-script'
  gem 'uglifier'
end

gem 'aws-s3'
gem 'devise'
gem 'futures_pipeline'
gem 'gravatar_image_tag'
gem 'haml'
gem 'jquery-rails'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem 'paperclip'

gem 'fb_graph'
gem 'linkedin', :git =>'git://github.com/pengwynn/linkedin.git', :branch => "2-0-stable"
gem 'twitter'

platforms :jruby do
  gem 'jruby-openssl'
  gem 'therubyrhino'
end

group :development, :test do
  gem 'faker'
  gem 'nifty-generators'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'sqlite3'
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
