source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.2", ">= 7.0.2.2"

gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem 'simple_command'
gem 'rest-client', '~> 2.1'
gem 'sidekiq'
gem 'redis'

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails", "~> 6.1"
  gem "faker", "~> 2.17"
  gem "rspec-rails", "~> 5.0"
  gem 'cpf_faker'
end

group :test do
  gem 'database_cleaner'
end

