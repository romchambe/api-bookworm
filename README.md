## Base setup

1. Create a new Rails app: `$ rails new my_app --api -T --database=postgresql` 
   - `--api` flag to create an API-only application
   - `-T` to exclude Minitest as default testing framework
   - `--database=postgresql` to use Postgre
2. Modify Gemfile and install gems: `$ bundle install`
3. Install rspec: `rails g rspec:install`
4. In `config/environments/production.rb`, uncomment the following line to force all communications between local browsers and remote servers to have SSL in production (NB: this works only with a Heroku domain, but for another domain, refer to [Heroku SSL docs](https://devcenter.heroku.com/articles/ssl)): 
```Ruby
config.force_ssl = true
```
5. Production webserver: by default, Heroku uses a pure-Ruby webserver called WEBrick, which is easy to set up and run but isn’t good at handling significant traffic. As a result, WEBrick isn’t suitable for production use, so we need to replace WEBrick with Puma. Puma is included by default in Rails 5, so we just need to replace the content of `config/puma.rb` by:
```Ruby
#config/puma.rb
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/
  # deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
```
and to create `Procfile` in the root directory of the app and insert the line: 
```
web: bundle exec puma -C config/puma.rb
```
6. Commit


## Enabling CORS

Following this tutorial frome (Sitepoint)[https://www.sitepoint.com/react-rails-5-1/]

1) We first need to add the rack-cors gem to our `Gemfile`:
```Ruby
gem 'rack-cors', :require => 'rack/cors'
```
2) We allow requests with certain origin to our API by adding the following bit to `config/application.rb`
```Ruby 
config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000'
    resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
  end
end
```
## User model

To be done

## Authentication

1) Add `lib` folder to our applicationload path: 
```Ruby
# config/application.rb

config.autoload_paths << Rails.root.join('lib')  
```

2) Create an `Auth` class that will be responsible for issuing and decoding JWT
```Ruby
# lib/auth.rb

require 'jwt'

class Auth
  
  ALGORITHM = 'HS256'
  
  def self.issue(payload)
    JWT.encode(
      payload,
      auth_secret,
      ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, 
      auth_secret, 
      true, 
      { algorithm: ALGORITHM }).first
  end

  def self.auth_secret
    Rails.application.secrets.secret_key_base
  end
end  
```
3) Controllers

To be done 

