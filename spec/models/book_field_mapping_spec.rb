# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookFieldMapping, type: :model do
  context 'validation tests' do
    let(:field_mapping) { build(:book_field_mapping, display_name: 'EAN', lookup_field: 'ean') }
    it 'ensures name presence' do
      field_mapping.display_name = nil
      expect(field_mapping).not_to be_valid
    end

    it 'ensures lookup_field presence' do
      field_mapping.lookup_field = nil
      expect(field_mapping).not_to be_valid
    end

    it 'ensures lookup_field belongs to Book column_names' do
      field_mapping.lookup_field = 'ABC'
      expect(field_mapping).not_to be_valid
    end

    it 'is not valid if field mapping already exists' do
      create(:book_field_mapping, display_name: 'ISBN', lookup_field: 'isbn')
      field_mapping.display_name = 'ISBN'
      field_mapping.lookup_field = 'isbn'
      expect(field_mapping).not_to be_valid
    end
  end
end
