source 'http://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 4.2' # TODO: Cannot upgrade rails to 5.0 until we have mongoid 6.0

gem 'mongoid', '~> 5.0' # TODO: Cannot upgrade mongoid to 6.0 until mongoid-rspec suports it
gem 'mongoid_search'
gem 'mongoid_taggable', git: 'git://github.com/wilkerlucio/mongoid_taggable.git'
gem 'mongoid-paperclip', require: 'mongoid_paperclip'

gem 'rake'
gem 'aws-sdk'
gem 'thin'

group :test, :development do
  gem 'rr'
  gem 'hoe'
  gem 'mongoid-rspec'
  gem 'rspec-rails'
  gem 'webrat'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'spork'
  gem 'simplecov'
  gem 'foreman'
  gem 'dotenv-rails'
end

