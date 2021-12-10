# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe RoutesController, type: :controller do
  fixtures :roles
  before(:each) do
    sign_in create(:user)
  end

  let(:route1) { create(:route) }
  let(:route2) { create(:route, action_name: 'details') }
  let(:route3) { create(:route, action_name: 'detail_guides') }

  describe 'index' do
    it 'returns a found response' do
      get :index
      expect(response.code).to eq('302')
    end
  end
end
