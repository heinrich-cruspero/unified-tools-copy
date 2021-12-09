# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feature, type: :model do
  context 'validation' do
    let(:feature) { build(:feature) }
    let(:route_1) { create(:route) }
    let(:route_2) { create(:route, action_name: 'show') }

    it 'validates presence of routes' do
      expect(feature).not_to be_valid
    end

    it 'is valid with unique routes' do
      routes = [route_1.id, route_2.id]
      routes.each do |route_id|
        feature.feature_routes.build(route_id: route_id)
      end

      expect(feature).to be_valid
    end

    it 'validates uniqueness of routes' do
      routes = [route_1.id, route_2.id, route_1.id]
      routes.each do |route_id|
        feature.feature_routes.build(route_id: route_id)
      end
      expect(feature).not_to be_valid
    end
  end
end
