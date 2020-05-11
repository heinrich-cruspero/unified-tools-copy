# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Amazon Shipments Import', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  let(:header) { 'SKU' }
  let(:row2) { 'ABC-227-04929' }
  let(:rows) { [header, row2] }

  let(:file_path) { 'tmp/test.csv' }
  let!(:csv) do
    CSV.open(file_path, 'w') do |csv|
      rows.each do |row|
        csv << row.split(',')
      end
    end
  end

  scenario '#delete page' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    click_link 'Delete'
    expect(page).to have_content('Amazon Shipments Delete Quantities')
  end

  scenario '#delete page do invalid upload' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    click_link 'Delete'
    expect(page).to have_content('Amazon Shipments Delete Quantities')
    click_button 'Upload'
    expect(page).to have_content('Missing csv file.')
  end

  scenario '#delete page do valid upload with unfound sku' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    click_link 'Delete'
    attach_file('csv_file', file_path)
    click_button 'Upload'
  end

  scenario '#delete page do valid upload without unfound sku' do
    amazon_shipment = FactoryBot.create(:amazon_shipment)

    IndabaSku.create(
      sku: 'ABC-227-04929',
      amazon_shipment_id: amazon_shipment.id,
      quantity: 1
    )

    visit amazon_shipments_path
    click_link 'Sign in with Google'
    click_link 'Delete'
    attach_file('csv_file', file_path)
    click_button 'Upload'
  end

  after(:each) { File.delete(file_path) }
end
