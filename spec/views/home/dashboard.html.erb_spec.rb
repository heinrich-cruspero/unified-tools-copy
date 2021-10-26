# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/dashboard.html.erb', type: :view do
  it 'renders dashboard' do
    render

    expect(rendered).to have_text 'Dashboard'
  end
end

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Home Dashboard', type: :feature do
  fixtures :books, :roles

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  scenario '#for a user with permission to Books' do
    user = create(:user)
    books_index_route = create(:route, :index,
                               controller_name: Book.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: books_index_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path
    expect(page).to have_content('Dashboard')

    within 'nav#sidebar' do
      expect(page).to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Book Details' do
    user = create(:user)
    books_details_route = create(:route, action_name: 'details',
                                         controller_name: Book.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: books_details_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Book Export Templates' do
    user = create(:user)
    templates_route = create(:route, :index,
                             controller_name: BookExportTemplate.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: templates_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Book Field Mappings' do
    user = create(:user)
    field_mapping_route = create(:route, :index,
                                 controller_name: BookFieldMapping.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: field_mapping_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Amazon Shipments' do
    user = create(:user)
    amazon_shipment_route = create(:route, :index,
                                   controller_name: AmazonShipment.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: amazon_shipment_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Amazon Orders' do
    user = create(:user)
    amazon_order_route = create(:route, :index,
                                controller_name: AmazonOrder.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: amazon_order_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Amazon Order Items' do
    user = create(:user)
    amazon_order_items_route = create(:route, :index,
                                      controller_name: AmazonOrderItem.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: amazon_order_items_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Features' do
    user = create(:user)
    features_route = create(:route, :index,
                            controller_name: Feature.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: features_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Users' do
    user = create(:user)
    users_route = create(:route, :index,
                         controller_name: User.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: users_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Roles' do
    user = create(:user)
    roles_route = create(:route, :index,
                         controller_name: Role.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: roles_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).to have_selector(:link_or_button, 'Roles')
    end
  end

  scenario '#for a user with permission to Guide Import' do
    user = create(:user)
    guide_imports_route = create(:route, action_name: 'index',
                                         controller_name: GuideImport.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: guide_imports_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
      expect(page).to have_selector(:link_or_button, 'Guide Imports')
    end
  end

  scenario '#for a user with permission to Submissions' do
    user = create(:user)
    submissions_route = create(:route, :index,
                               controller_name: Submission.name.pluralize.underscore)

    create(:permission, authorizable: user, permissible: submissions_route, has_access: true)
    login_as(user, scope: :user)
    visit root_path

    within 'nav#sidebar' do
      expect(page).not_to have_selector(:link_or_button, 'Books')
      expect(page).not_to have_selector(:link_or_button, 'Book Details')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Templates')
      expect(page).not_to have_selector(:link_or_button, 'Book Export Fields')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Shipments')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Orders')
      expect(page).not_to have_selector(:link_or_button, 'Amazon Order Items')
      expect(page).not_to have_selector(:link_or_button, 'Features')
      expect(page).not_to have_selector(:link_or_button, 'Users')
      expect(page).not_to have_selector(:link_or_button, 'Roles')
      expect(page).to have_selector(:link_or_button, 'Submissions')
    end
  end
end
# rubocop:enable Metrics/BlockLength
