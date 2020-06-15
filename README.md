# Set up
1. Clone `unified-tools` repository
2. Run `bundle install`
3. Run `bin/yarn install`

# DB Setup
1. run `rake db:db:setup` or `rake db:reset`

# Running of Test Scripts using Rspec
1. run `rspec`

# Google API Setup

1. Go to 'https://console.developers.google.com'
2. Create project, then select.
3. Go to Credentials, then select the "OAuth consent screen" tab on the left panel, and provide an 'EMAIL ADDRESS' and a 'Project Name'

# Credentials
1. Run `EDITOR=vi rails credentials:edit`

    secret_key_base: '*********'

3. Save

#Required Environment Variables
1.GOOGLE_APP_ID
2.GOOGLE_APP_SECRET