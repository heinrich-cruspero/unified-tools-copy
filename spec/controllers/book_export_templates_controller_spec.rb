# frozen_string_literal: true

require 'rails_helper'
require 'faker'
# rubocop:disable Metrics/BlockLength
RSpec.describe BookExportTemplatesController,
               type: :controller do
  let(:user) { create(:user, :super_admin) }
  before(:each) do
    sign_in user
  end

  let(:field_mapping_1) do
    create(
      :book_field_mapping, display_name: 'EAN', lookup_field: 'ean'
    )
  end
  let(:field_mapping_2) do
    create(
      :book_field_mapping, display_name: 'ISBN', lookup_field: 'isbn'
    )
  end
  let(:template) do
    create(
      :book_export_template, name: 'Template 1',
                             book_field_mappings: [field_mapping_1],
                             user: user
    )
  end

  describe 'actions' do
    it 'returns a found response' do
      get :index
      expect(response.code).to eq('200')
    end

    it 'returns a success response on show page' do
      get :show, params: { id: template.id }
      expect(response.code).to eq('200')
    end

    it 'returns a success response on new' do
      post :create, params: {
        book_export_template: {
          name: 'Template',
          book_field_mapping_ids: [field_mapping_1.id]
        }
      }
      expect(response.code).to eq('200')
    end

    it 'returns a success response on edit page' do
      get :edit, params: {
        id: template.id
      }
      expect(response.code).to eq('200')
    end

    it 'returns a success response on update' do
      patch :update, params: {
        id: template.id,
        book_export_template: {
          name: 'New Name',
          book_field_mapping_ids: [field_mapping_1.id, field_mapping_2.id]
        }
      }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on use page' do
      get :use, params: { id: template.id }
      expect(response.code).to eq('200')
    end

    it 'returns a success response on delete' do
      delete :destroy, params: { id: template.id }
      expect(response.code).to eq('302')
    end
  end
end
# rubocop:enable Metrics/BlockLength
