# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe AmazonShipmentPolicy do
  fixtures :roles
  subject { AmazonShipmentPolicy.new(user, amazon_shipment) }

  let(:amazon_shipment) { create(:amazon_shipment) }

  let(:index_route) do
    create(:route, :index,
           controller_name: AmazonShipment.name.pluralize.underscore)
  end

  let(:combine_route) do
    create(:route, action_name: 'combine',
                   controller_name: AmazonShipment.name.pluralize.underscore)
  end

  let(:indaba_skus_route) do
    create(:route, action_name: 'indaba_skus',
                   controller_name: AmazonShipment.name.pluralize.underscore)
  end

  let(:import_route) do
    create(:route, action_name: 'import',
                   controller_name: AmazonShipment.name.pluralize.underscore)
  end

  let(:delete_skus_route) do
    create(:route, action_name: 'delete_skus',
                   controller_name: AmazonShipment.name.pluralize.underscore)
  end

  let(:feature) do
    create(:feature, name: 'AmazonShipment',
                     routes: [index_route, combine_route, indaba_skus_route,
                              import_route, delete_skus_route])
  end

  context 'for a visitor' do
    let(:user) { FactoryBot.create(:user) }

    it { should_not permit(:index) }
    it { should_not permit(:combine) }
    it { should_not permit(:indaba_skus) }
    it { should_not permit(:import) }
    it { should_not permit(:delete_skus) }
  end

  context 'for a user with role permissions' do
    let(:user) { FactoryBot.create(:user, :store_manager) }
    before(:each) do
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: store_manager_role, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:combine) }
    it { should permit(:indaba_skus) }
    it { should permit(:import) }
    it { should permit(:delete_skus) }
  end

  context 'for a user with permissions' do
    let(:user) { FactoryBot.create(:user) }
    before(:each) do
      create(:permission, authorizable: user, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:combine) }
    it { should permit(:indaba_skus) }
    it { should permit(:import) }
    it { should permit(:delete_skus) }
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
      create(:permission, authorizable: user, permissible: delete_skus_route, has_access: false)
      should_not permit(:delete_skus)
    end
  end
end
# rubocop:enable Metrics/BlockLength
