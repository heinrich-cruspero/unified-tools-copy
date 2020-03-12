# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'amazon_shipments/index', type: :view do
  before(:each) do
    amazon_shipment_file = FactoryBot.create(:amazon_shipment_file)
    @amazon_shipments = WillPaginate::Collection.new(4, 10, 0)
    2.times do |index|
      @amazon_shipments << AmazonShipment.create!(isbn: "Isbn #{index}",
                                                  shipment_id: 'Shipment',
                                                  quantity_shipped: 2,
                                                  quantity_in_case: 3,
                                                  quantity_received: 4,
                                                  reconciled: false,
                                                  amazon_shipment_file_id: amazon_shipment_file.id)
    end
    assign(:test, @amazon_shipments) # for will_paginate
    assign(:amazon_shipment_items, @amazon_shipments)
  end

  it 'renders a list of amazon_shipments' do
    render
    assert_select 'tr>td', text: 'Isbn 0'.to_s, count: 1
    assert_select 'tr>td', text: 'Isbn 1'.to_s, count: 1
    assert_select 'tr>td', text: 'Shipment'.to_s, count: 2
    assert_select 'tr>td>span', text: 'No', count: 2
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

  scenario 'index page with search' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    expect(page).to have_content('Amazon Shipments')
    find_field('amazon-table-search-input').set Faker::Alphanumeric.alphanumeric(number: 10)
    click_button 'Submit'
  end
end
