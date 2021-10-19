# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Permission, type: :model do
  context 'validation tests' do
    let(:role) { Role.find_by(name: 'Admin') }
    let(:field_mapping) { create(:book_field_mapping, display_name: 'EAN', lookup_field: 'ean') }
    let(:permission) { build(:permission, authorizable: role, permissible: field_mapping) }

    it 'ensures authorizable presence' do
      permission.authorizable = nil
      expect(permission).not_to be_valid
    end

    it 'ensures permissible presence' do
      permission.permissible = nil
      expect(permission).not_to be_valid
    end

    it 'validates uniqueness of authorizable with permissible' do
      create(:permission, authorizable: role, permissible: field_mapping)
      expect(permission).not_to be_valid
    end
  end
end
