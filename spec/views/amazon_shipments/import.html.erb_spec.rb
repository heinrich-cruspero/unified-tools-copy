# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Amazon Shipments Import', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  let(:header) { 'ISBN, AZ SKU, Qty, Ship ID, SKU, Condition' }
  let(:row2) { '801027888, TI3P:0801027888:GOOD:RTEXT, 1, FBA15JRZQD8S, ABC-227-04929, Used - Good' }
  let(:row3) { '801027889, TI3P:0801027888:GOOD:RTEXT, 1, FBA15JRZQD8S, ABC-227-04929, Used - Good' }
  let(:rows) { [header, row2, row3] }

  let(:file_path) { 'tmp/test.csv' }
  let!(:csv) do
    CSV.open(file_path, 'w') do |csv|
      rows.each do |row|
        csv << row.split(',')
      end
    end
  end

  scenario '#import page' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    click_link 'Import'
    expect(page).to have_content('Amazon Shipments Import')
  end

  scenario '#import page do invalid upload' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    click_link 'Import'
    expect(page).to have_content('Amazon Shipments Import')
    click_button 'Upload'
    expect(page).to have_content('Missing csv file.')
  end

  scenario '#import page do valid upload' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    click_link 'Import'
    expect(page).to have_content('Amazon Shipments Import')
    attach_file('csv_file', file_path)
    click_button 'Upload'
  end

  after(:each) { File.delete(file_path) }
end
