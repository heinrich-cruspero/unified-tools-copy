# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe BookExportTemplatePolicy do
  fixtures :roles
  subject { BookExportTemplatePolicy.new(user, book_export_template) }

  let(:some_user) { create(:user, :super_admin) }

  let(:field) do
    create(
      :book_field_mapping,
      display_name: 'ISBN',
      lookup_field: 'isbn'
    )
  end
  let(:book_export_template) do
    create(:book_export_template,
           book_field_mappings: [field],
           user: user)
  end

  let(:book_export_template) do
    create(:book_export_template, name: 'AdminTemplate',
                                  book_field_mappings: [field],
                                  user: some_user)
  end

  let(:index_route) do
    create(:route, :index,
           controller_name: BookExportTemplate.name.pluralize.underscore)
  end
  let(:show_route) do
    create(:route, :show,
           controller_name: BookExportTemplate.name.pluralize.underscore)
  end
  let(:create_route) do
    create(:route, :create,
           controller_name: BookExportTemplate.name.pluralize.underscore)
  end
  let(:new_route) do
    create(:route, :new,
           controller_name: BookExportTemplate.name.pluralize.underscore)
  end
  let(:update_route) do
    create(:route, :update,
           controller_name: BookExportTemplate.name.pluralize.underscore)
  end
  let(:edit_route) do
    create(:route, :edit,
           controller_name: BookExportTemplate.name.pluralize.underscore)
  end
  let(:destroy_route) do
    create(:route, :destroy,
           controller_name: BookExportTemplate.name.pluralize.underscore)
  end
  let(:use_route) do
    create(:route, action_name: 'use',
                   controller_name: BookExportTemplate.name.pluralize.underscore)
  end

  let(:feature) do
    create(:feature, name: 'BookExportTemplate',
                     routes: [index_route, show_route, create_route,
                              new_route, update_route, edit_route,
                              destroy_route, use_route])
  end

  context 'for a visitor' do
    let(:user) { create(:user) }

    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:destroy) }
    it { should_not permit(:use) }
  end

  context 'for a user with role permissions' do
    let(:user) { create(:user, :store_manager) }
    before(:each) do
      store_manager_role = Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: store_manager_role, permissible: feature, has_access: true)
    end

    it { should permit(:index) }
    it { should_not permit(:edit) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should_not permit(:destroy) }
    it { should permit(:use) }
  end

  context 'for a user with permissions' do
    let(:user) { create(:user) }
    before(:each) do
      create(:permission, authorizable: user, permissible: feature, has_access: true)
    end
    it { should permit(:index) }
    it { should_not permit(:edit) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should_not permit(:destroy) }
    it { should permit(:use) }
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
                          permissible: use_route, has_access: true)
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
      should_not permit(:use)
    end

    it 'should prioritize user route permissions over role feature permissions' do
      create(:permission, authorizable: user, permissible: index_route, has_access: false)
      should_not permit(:index)
    end

    it 'should prioritize user route permissions over role route permissions' do
      user.roles.destroy_all
      user.roles << Role.find_by(name: 'StoreManager')
      create(:permission, authorizable: user, permissible: use_route, has_access: false)
      create(:permission, authorizable: user, permissible: new_route, has_access: true)
      should_not permit(:use)
      should permit(:new)
    end
  end

  context 'for a user that is not SuperAdmin' do
    let(:user) { create(:user, :store_manager) }
    before(:each) do
      create(:book_export_template, name: 'My Template',
                                    book_field_mappings: [field],
                                    user: user)
    end
    it 'should be able to view all existing templates' do
      templates = Pundit.policy_scope!(user, BookExportTemplate)
      expect(templates.include?(book_export_template)).to eq(true)
    end

    it 'should be able to only view and use other templates' do
      create(:permission, authorizable: user, permissible: feature, has_access: true)

      should_not permit(:edit)
      should permit(:show)
      should permit(:create)
      should permit(:new)
      should_not permit(:destroy)
      should permit(:use)
    end
  end

  context 'for a user that is SuperAdmin' do
    let(:user) { create(:user, :super_admin) }

    it 'should be able to have all permission to other templates' do
      should permit(:edit)
      should permit(:show)
      should permit(:create)
      should permit(:new)
      should permit(:destroy)
      should permit(:use)
    end
  end
end
# rubocop:enable Metrics/BlockLength
