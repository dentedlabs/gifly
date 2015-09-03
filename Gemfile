source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# CONFIG
gem 'simpleconfig' # rails environment configurations

# database
gem 'nobrainer'
# gem 'mongoid'

gem 'omniauth'

# Model
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'yajl-ruby', require: 'yajl'
gem 'kaminari-nobrainer'
gem 'services'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development, :test do
  gem 'faker'
  gem 'shoulda'
  gem 'webmock'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

# Notifiers
gem 'slack-notifier'

gem 'rest-client'

# gem 'travis'

group :development, :production do
  # Notifications / Monitoring
  gem 'newrelic_rpm'
  # Caching
  # gem 'dalli'
  gem 'unicorn'
  gem 'sidekiq'
end

group :production do
  gem 'le' # LogEntries
end

gem 'mina'
gem 'mina-unicorn', :require => false
