# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe AmazonOrderItemPolicy do
  fixtures :roles
  subject { AmazonOrderItemPolicy.new(user, amazon_order_item) }

  let(:amazon_order_item) do
    create(:amazon_order_item,
           order_item_id: 1,
           amazon_order: AmazonOrder.create!(
             amazon_order_id: 1, order_total: 100, status: 'done',
             purchase_date: Time.now - 3.days
           ))
  end

  let(:index_route) do
    create(:route, :index,
           controller_name: AmazonOrderItem.name.pluralize.underscore)
  end

  let(:feature) do
    create(:feature, name: 'AmazonOrderItem',
                     routes: [index_route])
  end

  context 'for a visitor' do
    let(:user) { FactoryBot.create(:user) }

    it { should_not permit(:index) }
  end

  context 'for a user with role permissions' do
    let(:user) { FactoryBot.create(:user, :store_manager) }
    before(:each) do
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: store_manager_role, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
  end

  context 'for a user with permissions' do
    let(:user) { FactoryBot.create(:user) }
    before(:each) do
      create(:permission, authorizable: user, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
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
      create(:permission, authorizable: user, permissible: index_route, has_access: false)
      should_not permit(:index)
    end
  end
end
# rubocop:enable Metrics/BlockLength
