# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Amazon order index page spec', type: :feature do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  scenario '#index page' do
    user = create(:user, :super_admin)
    login_as(user, scope: :user)
    visit amazon_orders_path

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

  scenario '#index page for a user without index permission' do
    user = create(:user)
    login_as(user, scope: :user)
    visit amazon_orders_path

    expect(page).not_to have_selector(:link_or_button, 'Export All')
    expect(page).not_to have_selector(:link_or_button, 'Export')
  end

  scenario '#index page for a user with index permission but without export permission' do
    user = create(:user)
    index_route = create(:route, :index,
                         controller_name: AmazonOrder.name.pluralize.underscore)
    export_route = create(:route, action_name: 'export',
                                  controller_name: AmazonOrder.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: index_route, has_access: true)
    create(:permission, authorizable: user, permissible: export_route, has_access: true)

    login_as(user, scope: :user)
    visit amazon_orders_path

    expect(page).to have_selector(:link_or_button, 'Export All')
    expect(page).to have_selector(:link_or_button, 'Export')
  end
end
