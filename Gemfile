source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

# Asset template engines
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-script'
  gem 'uglifier'
end

gem 'ckeditor'
gem 'devise'
gem 'jquery-rails'
gem "paperclip", "~> 2.3"

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
