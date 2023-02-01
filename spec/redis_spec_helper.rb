RSpec.configure do |config|
  config.before(:each) do
    User.redis.flushdb
  end
end
