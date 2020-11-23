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

#Required Environment Variables
1. GOOGLE_APP_ID
2. GOOGLE_APP_SECRET

# Credentials
1. Run `EDITOR=vi rails credentials:edit`
    secret_key_base: '*********'

2. Save

## AWS Credentials
1. Run `EDITOR=vi rails credentials:edit` again to set up, aws configuration
    aws:
        access_key_id::
        secret_access_key:
        ses_smtp_username:
        ses_smtp_password:

    development:
      aws:
        region:
        bucket_name:

    production:
      aws:
        region:
        bucket_name:

## Job Error Email
1. Run `EDITOR=vim rails credentials:edit` again to set up, jobs email group
    developer_email_group: ["marc@rev365.com", "karim@rev365.com", "ramya@rev365.com"]

## Data Credentials
1. Run `EDITOR=vim rails credentials:edit` again to set up, DataWH configuration
    datawh:
        url:
        api_token:

2. set up IndabaFBAZ configuration
    indabafbaz:
        host:
        database:
        username:
        password:
        port:

3. set up DataWH configuration
    datawhdb:
        host:
        database:
        username:
        password:
        port:
