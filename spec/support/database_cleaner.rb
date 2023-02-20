require 'database_cleaner/active_record'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy =
      if example.metadata[:js]
        :truncation
      else
        :transaction
      end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean

    # NOTE: Use it when your testcase is using active storage
    # FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
end
