# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe PermissionsController, type: :controller do
  let(:user) { create(:user) }
  before(:each) do
    sign_in user
  end

  let(:route) { create(:route) }
  let(:shipments_route) { create(:route, controller_name: 'Shipments', action_name: 'index') }
  let(:feature) { create(:feature, routes: [route]) }
  let(:shipments_feature) { create(:feature, routes: [shipments_route]) }
  let(:permission) { create(:permission, authorizable: user, permissible: feature) }

  describe 'index' do
    it 'returns a success response on show page' do
      get :show, params: { id: permission.id }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on new' do
      get :new, params: { authorizable: user, permissible: shipments_feature }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on edit page' do
      get :edit, params: { id: permission.id }
      expect(response.code).to eq('302')
    end

    it 'returns a success response on delete' do
      delete :destroy, params: { id: permission.id }
      expect(response.code).to eq('302')
    end
  end
end
