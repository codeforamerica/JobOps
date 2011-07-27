source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

gem 'ckeditor', '3.4.2.pre'
gem 'devise'
gem 'jquery-rails'

# Asset template engines
gem 'coffee-script'
gem 'sass-rails', '~> 3.1.0.rc'
gem 'therubyracer', :platforms => :ruby
gem 'uglifier'

platforms :jruby do
  gem 'jruby-openssl'
  gem 'therubyrhino'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'sqlite3'
end

group :test do
  gem 'factory_girl_rails'
  gem 'webrat'
end

group :production do
  gem 'pg'
end
