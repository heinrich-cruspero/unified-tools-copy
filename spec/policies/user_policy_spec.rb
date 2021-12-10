# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe UserPolicy do
  fixtures :roles
  subject { UserPolicy.new(user, users) }

  let(:users) { create(:user) }

  let(:index_route) do
    create(:route, :index,
           controller_name: User.name.pluralize.underscore)
  end
  let(:show_route) do
    create(:route, :show,
           controller_name: User.name.pluralize.underscore)
  end
  let(:update_route) do
    create(:route, :update,
           controller_name: User.name.pluralize.underscore)
  end

  let(:feature) do
    create(:feature, name: 'Role',
                     routes: [index_route, show_route, update_route])
  end

  context 'for a visitor' do
    let(:user) { create(:user) }

    it { should_not permit(:index) }
    it { should_not permit(:show) }
    it { should_not permit(:update) }
  end

  context 'for a user with role permissions' do
    let(:user) { create(:user, :store_manager) }
    before(:each) do
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: store_manager_role, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:update) }
  end

  context 'for a user with permissions' do
    let(:user) { create(:user) }
    before(:each) do
      create(:permission, authorizable: user, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:update) }
  end

  context 'for a user with both role and user permissions' do
    let(:user) { create(:user) }
    let(:books_index_route) do
      create(:route, :index,
             controller_name: Book.name.pluralize.underscore)
    end
    before(:each) do
      user_role = Role.find_by(name: 'User')
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: user_role, permissible: feature, has_access: true)
      create(:permission, authorizable: store_manager_role,
                          permissible: update_route, has_access: true)
      create(:permission, authorizable: store_manager_role,
                          permissible: show_route, has_access: false)
    end

    it 'should prioritize user feature permissions over role feature permissions' do
      create(:permission, authorizable: user, permissible: feature, has_access: false)
      should_not permit(:index)
      should_not permit(:show)
      should_not permit(:update)
    end

    it 'should prioritize user route permissions over role feature permissions' do
      create(:permission, authorizable: user, permissible: index_route, has_access: false)
      should_not permit(:index)
    end

    it 'should prioritize user route permissions over role route permissions' do
      user.roles.destroy_all
      user.roles << Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: user, permissible: update_route, has_access: false)
      create(:permission, authorizable: user, permissible: show_route, has_access: true)
      should_not permit(:update)
      should permit(:show)
    end
  end
end
# rubocop:enable Metrics/BlockLength
