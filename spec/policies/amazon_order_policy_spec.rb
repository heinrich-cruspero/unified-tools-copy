# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe AmazonOrderPolicy do
  subject { AmazonOrderPolicy.new(user, amazon_order) }

  let(:amazon_order) { create(:amazon_order, amazon_order_id: 999) }

  let(:index_route) do
    create(:route, :index,
           controller_name: AmazonOrder.name.pluralize.underscore)
  end

  let(:show_route) do
    create(:route, :show,
           controller_name: AmazonOrder.name.pluralize.underscore)
  end

  let(:export_route) do
    create(:route, action_name: 'export',
                   controller_name: AmazonOrder.name.pluralize.underscore)
  end

  let(:feature) do
    create(:feature, name: 'AmazonOrder',
                     routes: [index_route, show_route,
                              export_route])
  end

  context 'for a visitor' do
    let(:user) { FactoryBot.create(:user) }

    it { should_not permit(:index) }
    it { should_not permit(:show) }
    it { should_not permit(:export) }
  end

  context 'for a user with role permissions' do
    let(:user) { FactoryBot.create(:user, :store_manager) }
    before(:each) do
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: store_manager_role, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:export) }
  end

  context 'for a user with permissions' do
    let(:user) { FactoryBot.create(:user) }
    before(:each) do
      create(:permission, authorizable: user, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:export) }
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
