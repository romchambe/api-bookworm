source 'https://rubygems.org'

gem 'rails', '~> 5.2'     # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'puma', '~> 3.7'        # Use Puma as the app server
gem 'jbuilder', '~> 2.5'    # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'redis', '~> 4.0'       # Use Redis adapter to run Action Cable in production
gem 'bcrypt', '~> 3.1.7'    # Authentication
gem 'jwt'                   # encoding and decoding of HMACSHA256 tokens available in the Rails application  
gem 'pg', '~> 1.0'          # Database
gem 'rack-cors',  require: 'rack/cors'  # Allow Cross Origin Ressource Sharing
gem 'delayed_job_active_record'         # Delayed jobs => schedule tasks
gem 'bootsnap', require: false

gem "google-cloud-storage", "~> 1.8", require: false


group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'spring'   # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
end