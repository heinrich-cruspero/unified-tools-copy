# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'amazon_shipments/index', type: :view do
  before(:each) do
    @amazon_shipments = WillPaginate::Collection.new(4, 10, 0)
    2.times do |_index|
      @amazon_shipments << create(:amazon_shipment)
    end
    assign(:test, @amazon_shipments) # for will_paginate
    assign(:amazon_shipment_items, @amazon_shipments)
  end
end

RSpec.describe 'Amazon Shipments Index Page', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  scenario 'index page' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    expect(page).to have_content('Amazon Shipments')
    click_link '20 Days Pending'
    click_link 'Pending'
    click_link 'Combine Shipments'
  end
end
