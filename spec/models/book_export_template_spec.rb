# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookExportTemplate, type: :model do
  context 'validation tests' do
    let(:template) { build(:book_export_template) }
    let(:field_1) { create(:book_field_mapping, display_name: 'EAN', lookup_field: 'ean') }
    let(:field_2) { create(:book_field_mapping, display_name: 'ISBN', lookup_field: 'isbn') }
    let(:field_3) { create(:book_field_mapping, display_name: 'OE_ISBN', lookup_field: 'oe_isbn') }
    it 'ensures name presence' do
      template.name = nil
      expect(template).not_to be_valid
    end

    it 'ensures field mappings presence' do
      expect(template).not_to be_valid
    end

    it 'is not valid with duplicate field mappings' do
      template.book_field_mappings = [field_1, field_2, field_3, field_1]
      expect(template).not_to be_valid
    end
  end
end
