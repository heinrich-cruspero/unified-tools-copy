# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe BookFieldMappingPolicy do
  fixtures :roles
  subject { BookFieldMappingPolicy.new(user, book_field_mapping) }

  let(:book_field_mapping) do
    create(
      :book_field_mapping,
      display_name: 'ISBN',
      lookup_field: 'isbn'
    )
  end
  let(:ean_field) do
    create(
      :book_field_mapping,
      display_name: 'EAN',
      lookup_field: 'ean'
    )
  end

  let(:author_field) do
    create(
      :book_field_mapping,
      display_name: 'Author',
      lookup_field: 'author'
    )
  end

  let(:index_route) do
    create(:route, :index,
           controller_name: BookFieldMapping.name.pluralize.underscore)
  end
  let(:show_route) do
    create(:route, :show,
           controller_name: BookFieldMapping.name.pluralize.underscore)
  end
  let(:create_route) do
    create(:route, :create,
           controller_name: BookFieldMapping.name.pluralize.underscore)
  end
  let(:new_route) do
    create(:route, :new,
           controller_name: BookFieldMapping.name.pluralize.underscore)
  end
  let(:update_route) do
    create(:route, :update,
           controller_name: BookFieldMapping.name.pluralize.underscore)
  end
  let(:edit_route) do
    create(:route, :edit,
           controller_name: BookFieldMapping.name.pluralize.underscore)
  end
  let(:destroy_route) do
    create(:route, :destroy,
           controller_name: BookFieldMapping.name.pluralize.underscore)
  end

  let(:feature) do
    create(:feature, name: 'BookFieldMapping',
                     routes: [index_route, show_route, create_route,
                              new_route, update_route, edit_route,
                              destroy_route])
  end

  context 'for a visitor' do
    let(:user) { FactoryBot.create(:user) }

    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:destroy) }
  end

  context 'for a user with role permissions' do
    let(:user) { FactoryBot.create(:user, :store_manager) }
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
    let(:user) { FactoryBot.create(:user) }
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
                          permissible: update_route, has_access: true)
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
      create(:permission, authorizable: user, permissible: update_route, has_access: false)
      create(:permission, authorizable: user, permissible: destroy_route, has_access: true)
      should_not permit(:update)
      should permit(:destroy)
    end
  end

  context 'for a user that is not SuperAdmin - BookFieldMappings' do
    let(:user) { create(:user, :store_manager) }
    before(:each) do
      create(:permission, authorizable: user, permissible: author_field, has_access: true)
    end
    it 'should limit and can only use set book field mappings' do
      field_mappings = Pundit.policy_scope!(user, BookFieldMapping)

      expect(field_mappings.include?(author_field)).to eq(true)
      expect(field_mappings.include?(ean_field)).to eq(false)
    end
  end
end
# rubocop:enable Metrics/BlockLength
