# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe BookPolicy do
  fixtures :roles
  subject { BookPolicy.new(user, book) }

  let(:book) { create(:book) }

  let(:index_route) do
    create(:route, :index,
           controller_name: Book.name.pluralize.underscore)
  end

  let(:details_route) do
    create(:route, action_name: 'details',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:detail_guides_route) do
    create(:route, action_name: 'detail_guides',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:quantity_history_route) do
    create(:route, action_name: 'quantity_history',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:rental_history_route) do
    create(:route, action_name: 'rental_history',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:amazon_history_route) do
    create(:route, action_name: 'amazon_history',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:guide_data_history_route) do
    create(:route, action_name: 'guide_data_history',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:amazon_orders_route) do
    create(:route, action_name: 'amazon_orders',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:sales_rank_history_route) do
    create(:route, action_name: 'sales_rank_history',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:amazon_prices_history_route) do
    create(:route, action_name: 'amazon_prices_history',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:link_oe_isbn_route) do
    create(:route, action_name: 'link_oe_isbn',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:link_oe_isbn_import_route) do
    create(:route, action_name: 'link_oe_isbn_import',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:add_isbn_route) do
    create(:route, action_name: 'add_isbn',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:add_isbn_import_route) do
    create(:route, action_name: 'add_isbn_import',
                   controller_name: Book.name.pluralize.underscore)
  end

  let(:feature) do
    create(:feature, name: 'Books',
                     routes: [index_route, details_route, detail_guides_route,
                              quantity_history_route, rental_history_route,
                              amazon_history_route, guide_data_history_route,
                              amazon_orders_route, sales_rank_history_route,
                              amazon_prices_history_route, link_oe_isbn_route,
                              link_oe_isbn_import_route, add_isbn_route, add_isbn_import_route])
  end

  context 'for a visitor' do
    let(:user) { FactoryBot.create(:user) }

    it { should_not permit(:index) }
    it { should_not permit(:details) }
    it { should_not permit(:detail_guides) }
    it { should_not permit(:quantity_history) }
    it { should_not permit(:rental_history) }
    it { should_not permit(:amazon_history) }
    it { should_not permit(:guide_data_history) }
    it { should_not permit(:amazon_orders) }
    it { should_not permit(:sales_rank_history) }
    it { should_not permit(:amazon_prices_history) }
    it { should_not permit(:link_oe_isbn) }
    it { should_not permit(:link_oe_isbn_import) }
    it { should_not permit(:add_isbn) }
    it { should_not permit(:add_isbn_import) }
  end

  context 'for a user with role permissions' do
    let(:user) { FactoryBot.create(:user, :store_manager) }
    before(:each) do
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: store_manager_role, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:details) }
    it { should permit(:detail_guides) }
    it { should permit(:quantity_history) }
    it { should permit(:rental_history) }
    it { should permit(:amazon_history) }
    it { should permit(:guide_data_history) }
    it { should permit(:amazon_orders) }
    it { should permit(:sales_rank_history) }
    it { should permit(:amazon_prices_history) }
    it { should permit(:link_oe_isbn) }
    it { should permit(:link_oe_isbn_import) }
    it { should permit(:add_isbn) }
    it { should permit(:add_isbn_import) }
  end

  context 'for a user with permissions' do
    let(:user) { FactoryBot.create(:user) }
    before(:each) do
      create(:permission, authorizable: user, permissible: feature, has_access: true)
    end
    it { should permit(:details) }
    it { should permit(:detail_guides) }
    it { should permit(:quantity_history) }
    it { should permit(:rental_history) }
    it { should permit(:amazon_history) }
    it { should permit(:guide_data_history) }
    it { should permit(:amazon_orders) }
    it { should permit(:sales_rank_history) }
    it { should permit(:amazon_prices_history) }
    it { should permit(:link_oe_isbn) }
    it { should permit(:link_oe_isbn_import) }
    it { should permit(:add_isbn) }
    it { should permit(:add_isbn_import) }
  end

  context 'for a user with both role and user permissions' do
    let(:user) { FactoryBot.create(:user) }
    let(:books_index_route) do
      create(:route, :index,
             controller_name: Book.name.pluralize.underscore)
    end
    before(:each) do
      user_role = Role.find_by(name: 'User')
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: user_role, permissible: feature, has_access: true)
      create(:permission, authorizable: store_manager_role,
                          permissible: index_route, has_access: false)
    end

    it 'should prioritize user feature permissions over role feature permissions' do
      create(:permission, authorizable: user, permissible: feature, has_access: false)
      should_not permit(:index)
    end

    it 'should prioritize user route permissions over role feature permissions' do
      create(:permission, authorizable: user, permissible: index_route, has_access: false)
      should_not permit(:index)
    end

    it 'should prioritize user route permissions over role route permissions' do
      user.roles.destroy_all
      user.roles << Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: user, permissible: add_isbn_route, has_access: true)
      should permit(:add_isbn)
    end
  end
end
# rubocop:enable Metrics/BlockLength
