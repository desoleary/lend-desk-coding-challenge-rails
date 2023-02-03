DEVELOPMENT_ENCRYPTOR_COST = 10
TEST_ENCRYPTOR_COST = 6

Rails.configuration.after_initialize do
  # lower bcrypt cost when in dev-like environments only
  # default time cost is approx 256ms

  if Rails.env.development?
    PasswordEncryptor.cost = DEVELOPMENT_ENCRYPTOR_COST # approx time cost 70ms
  elsif Rails.env.test?
    PasswordEncryptor.cost = TEST_ENCRYPTOR_COST # approx time cost 15ms
  end
end
