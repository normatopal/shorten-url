require 'rubygems'
require 'factory_girl_rails'
require 'database_cleaner'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
#require 'spec_helper'
require 'rspec/rails'

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# Checks for pending migrations before tests are run.

# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Include Factory Girl syntax to simplify calls to factories
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = false

  # allow controller tests
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
     DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
      DatabaseCleaner.start
  end

  config.after(:each) do
      DatabaseCleaner.clean
  end

end
