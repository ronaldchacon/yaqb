# frozen_string_literal: true

require 'bundler/setup'
require 'yaqb'
require 'pry'
require 'active_record'
require 'database_cleaner'
require 'factory_bot'
require 'faker'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
load File.join(File.dirname(__FILE__), 'support', 'schema.rb')
require File.join(File.dirname(__FILE__), 'support', 'models.rb')

Yaqb.config.paginator = :kaminari

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
