# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe SubmissionPolicy do
  subject { SubmissionPolicy.new(user, submission) }

  let(:user) { create(:user) }
  let(:submission) { create(:submission, user: user) }

  let(:index_route) do
    create(:route, :index,
           controller_name: Submission.name.pluralize.underscore)
  end

  let(:admin_index_route) do
    create(:route, action_name: 'admin_index',
           controller_name: Submission.name.pluralize.underscore)
  end

  let(:show_route) do
    create(:route, :show,
           controller_name: Submission.name.pluralize.underscore)
  end
  let(:create_route) do
    create(:route, :create,
           controller_name: Submission.name.pluralize.underscore)
  end
  let(:new_route) do
    create(:route, :new,
           controller_name: Submission.name.pluralize.underscore)
  end
  let(:update_route) do
    create(:route, :update,
           controller_name: Submission.name.pluralize.underscore)
  end
  let(:edit_route) do
    create(:route, :edit,
           controller_name: Submission.name.pluralize.underscore)
  end
  let(:destroy_route) do
    create(:route, :destroy,
           controller_name: Submission.name.pluralize.underscore)
  end

  let(:feature) do
    create(:feature, name: 'Submission',
                     routes: [admin_index_route, index_route, show_route, create_route,
                              new_route, update_route, edit_route,
                              destroy_route])
  end

  context 'for a visitor' do
    let(:user) { create(:user) }

    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:destroy) }
  end

  context 'for a user with role permissions' do
    let(:user) { create(:user, :store_manager) }
    before(:each) do
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: store_manager_role, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:edit) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:destroy) }
  end

  context 'for a user with permissions' do
    let(:user) { create(:user) }
    before(:each) do
      create(:permission, authorizable: user, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should permit(:edit) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:destroy) }
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
                          permissible: edit_route, has_access: true)
      create(:permission, authorizable: store_manager_role,
                          permissible: destroy_route, has_access: false)
    end

    it 'should prioritize user feature permissions over role feature permissions' do
      create(:permission, authorizable: user, permissible: feature, has_access: false)
      should_not permit(:index)
      should_not permit(:edit)
      should_not permit(:show)
      should_not permit(:create)
      should_not permit(:new)
      should_not permit(:destroy)
    end

    it 'should prioritize user route permissions over role feature permissions' do
      create(:permission, authorizable: user, permissible: index_route, has_access: false)
      should_not permit(:index)
    end

    it 'should prioritize user route permissions over role route permissions' do
      user.roles.destroy_all
      user.roles << Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: user, permissible: edit_route, has_access: false)
      create(:permission, authorizable: user, permissible: admin_index_route, has_access: true)
      create(:permission, authorizable: user, permissible: destroy_route, has_access: true)
      should_not permit(:edit)
      should permit(:destroy)
    end
  end
end
# rubocop:enable Metrics/BlockLength
