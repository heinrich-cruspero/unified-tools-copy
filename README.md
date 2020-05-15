# Set up
1. Clone `unified-tools` repository
2. Run `bundle install`
3. Run `bin/yarn install`

# DB Setup
1. run `rake db:create`, `rake db:migrate`

# Running of Test Scripts using Rspec
1. run `rspec`

# Google API Setup

1. Go to 'https://console.developers.google.com'
2. Create project, then select.
3. Go to Credentials, then select the "OAuth consent screen" tab on the left panel, and provide an 'EMAIL ADDRESS' and a 'Project Name'

# Credentials
1. Run `EDITOR=vi bin/rails credentials:edit` in cmd to create master.key and credentials.yml.enc files inside config.
2. Run `EDITOR=vi rails credentials:edit` againg to set up, google and aws key

  google:
    client_id: '`<google_client_id>`'
    secret_key: '`<google_secret_key>`''

3. Save

