# frozen_string_literal: true

OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
  provider: 'google_oauth2',
  uid: '12345678910',
  info: {
    email: 'joe@rev365.com',
    first_name: 'Joe',
    last_name: 'Smith'
  },
  credentials: {
    token: 'abcdefg12345',
    refresh_token: '12345abcdefg',
    expires_at: DateTime.now
  }
)

OmniAuth.config.mock_auth[:invalid_google_oauth2] = OmniAuth::AuthHash.new(
  provider: 'google_oauth2',
  uid: '12345678910',
  info: {
    email: 'joe@gmail.com',
    first_name: 'Joe',
    last_name: 'Smith'
  },
  credentials: {
    token: 'abcdefg12345',
    refresh_token: '12345abcdefg',
    expires_at: DateTime.now
  }
)
