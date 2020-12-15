# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Amazon order index page spec', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  scenario '#index page' do
    visit amazon_orders_path
    click_link 'Sign in with Google'

    expect(page).to have_content('Amazon Orders')
    expect(page).to have_css(
      'table[data-source="/amazon_orders.json?filters%5B'\
      'purchase_end_date%5D=&filters%5Bpurchase_start_date%5D="]'
    )
    within 'table#amazon-orders-datatable' do
      expect(page).to have_text 'Order'
      expect(page).to have_text 'Total'
      expect(page).to have_text 'Purchase'
      expect(page).to have_text 'Date'
      expect(page).to have_text 'Status'
    end
  end
end
