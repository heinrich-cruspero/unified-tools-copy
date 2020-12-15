# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe BookFieldMappingsController, type: :controller do
  before(:each) do
    sign_in create(:user)
  end

  let(:field_mapping) do
    create(
      :book_field_mapping, display_name: 'EAN', lookup_field: 'ean'
    )
  end

  describe 'actions' do
    it 'returns a found response' do
      get :index
      expect(response.code).to eq('302')
    end

    it 'returns a success response on show page' do
      get :show, params: { id: field_mapping.id }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on new' do
      get :new, params: { display_name: 'ISBN', lookup_field: 'isbn' }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on edit page' do
      get :edit, params: { id: field_mapping.id }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on delete' do
      delete :destroy, params: { id: field_mapping.id }
      expect(response.code).to eq('302')
    end
  end
end
