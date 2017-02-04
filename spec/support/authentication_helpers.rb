module FeatureMacros
  def mock_facebook(name)
    around(:each) do |example|
      user = respond_to?(name) ? public_send(name) : create(name)
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:facebook, info: { email: user.email })
      example.run
      OmniAuth.config.test_mode = false
    end
  end

  def mock_sign_in(name)
    before do
      user = respond_to?(name) ? public_send(name) : create(name)
      sign_in user
    end
  end
end

RSpec.configure do |config|
  config.extend FeatureMacros, type: :feature
end