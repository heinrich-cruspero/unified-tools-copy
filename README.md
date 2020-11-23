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

# Credentials `EDITOR=vi rails credentials:edit`

## AWS Credentials
    secret_key_base:

## AWS Credentials
    aws:  
        access_key_id:  
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
    developer_email_group: ["marc@rev365.com", "karim@rev365.com", "ramya@rev365.com"]

## DataWH API
    datawh:
        url:
        api_token:

## FBAZ DB
    indabafbaz:
        host:
        database:
        username:
        password:
        port:

## DataWh DB
    development:
        datawhdb:
            host:
            database:
            username:
            password:
            port:

    production:
        datawhdb:
            host:
            database:
            username:
            password:
            port:
