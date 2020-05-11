# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'amazon_shipments/index', type: :view do
  before(:each) do
    amazon_shipment_file = FactoryBot.create(:amazon_shipment_file)
    @amazon_shipments = WillPaginate::Collection.new(4, 10, 0)
    2.times do |_index|
      @amazon_shipments << create(:amazon_shipment)
    end
    assign(:test, @amazon_shipments) # for will_paginate
    assign(:amazon_shipment_items, @amazon_shipments)
  end

  it 'renders a list of amazon_shipments' do
    render
    assert_select 'tr>td', text: @amazon_shipments[0].isbn.to_s, count: 1
    assert_select 'tr>td', text: @amazon_shipments[1].isbn.to_s, count: 1
    assert_select 'tr>td', text: @amazon_shipments[0].shipment_id.to_s, count: 1
    assert_select 'tr>td', text: @amazon_shipments[1].shipment_id.to_s, count: 1
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
    click_link 'Indaba SKU Level'
  end

  scenario 'date filter' do
    visit amazon_shipments_path
    click_link 'Sign in with Google'
    expect(page).to have_content('Amazon Shipments')
    click_link 'Indaba SKU Level'
    find_field('daterange').set '2020-03-12 - 2020-03-12'
    click_button 'Submit'
  end
end
