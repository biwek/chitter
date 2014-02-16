ENV["RACK_ENV"] = "test"

require 'data_mapper'
require 'database_cleaner'
require 'capybara/rspec'
require_relative '../app/chitter'

Capybara.app = Chitter

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # this will make sure that database is cleared after every test run
  config.before(:suite) do 
  	DatabaseCleaner.strategy = :transaction
  	DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do 
  	DatabaseCleaner.start
  end

  config.after(:each) do 
  	DatabaseCleaner.clean
  end
end
