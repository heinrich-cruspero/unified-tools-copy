# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Amazon order items index page spec', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  scenario '#index page' do
    visit amazon_order_items_path
    click_link 'Sign in with Google'

    expect(page).to have_content('Amazon Order Items')
    expect(page).to have_css('table[data-source="/amazon_order_items.json"]')
    within 'table#amazon-order-items-datatable' do
      expect(page).to have_text 'ASIN'
      expect(page).to have_text 'Amazon Order Id'
      expect(page).to have_text 'Sale Type Id'
      expect(page).to have_text 'Quantity Ordered'
      expect(page).to have_text 'Item Price'
      expect(page).to have_text 'Buy Out'
      expect(page).to have_text 'RNI'
      expect(page).to have_text 'Action Date'
      expect(page).to have_text 'Expired'
      expect(page).to have_text 'Seller SKU'
      expect(page).to have_text 'Buy Out Price'
    end
  end
end