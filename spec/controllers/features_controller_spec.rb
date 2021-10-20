# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe FeaturesController, type: :controller do
  before(:each) do
    sign_in create(:user)
  end

  let(:route1) { create(:route) }
  let(:route2) { create(:route, action_name: 'details') }
  let(:route3) { create(:route, action_name: 'detail_guides') }
  let(:feature) do
    create(
      :feature, routes: [route1, route2]
    )
  end

  describe 'index' do
    it 'returns a found response' do
      get :index
      expect(response.code).to eq('302')
    end

    it 'returns a success response on show page' do
      get :show, params: { id: feature.id }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on new' do
      get :new, params: { name: 'Shipments', description: 'isbn', routes: [route1] }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on edit page' do
      get :edit, params: { id: feature.id }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on delete' do
      delete :destroy, params: { id: feature.id }
      expect(response.code).to eq('302')
    end
  end
end
