# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookExportTemplate, type: :model do
  context 'validation tests' do
    let(:user) { create(:user) }
    let(:template) { build(:book_export_template, user: user) }

    let(:field_1) { create(:book_field_mapping, display_name: 'EAN', lookup_field: 'ean') }
    let(:field_2) { create(:book_field_mapping, display_name: 'ISBN', lookup_field: 'isbn') }
    let(:field_3) { create(:book_field_mapping, display_name: 'OE_ISBN', lookup_field: 'oe_isbn') }
    let(:existing_template) { build(:book_export_template, name: 'template1', user: user) }

    it 'ensures name presence' do
      template.name = nil
      expect(template).not_to be_valid
    end

    it 'ensures field mappings presence' do
      expect(template).not_to be_valid
    end

    it 'is not valid if template name already exists' do
      existing_template.book_export_template_field_mappings.build(
        position: 0,
        book_field_mapping_id: field_1.id
      ).save
      fields = [field_1.id, field_2.id, field_3.id]
      template.name = 'template1'
      fields.each_with_index do |field, index|
        template.book_export_template_field_mappings.build(
          book_field_mapping_id: field,
          position: index
        )
      end
      expect(template).not_to be_valid
    end

    it 'is valid with unique field mappings' do
      fields = [field_1.id, field_2.id, field_3.id]
      fields.each_with_index do |field, index|
        template.book_export_template_field_mappings.build(
          book_field_mapping_id: field,
          position: index
        )
      end
      expect(template).to be_valid
    end

    it 'is not valid with duplicate field mappings' do
      fields = [field_1.id, field_2.id, field_3.id, field_1.id]
      fields.each_with_index do |field, index|
        template.book_export_template_field_mappings.build(
          book_field_mapping_id: field,
          position: index
        )
      end
      expect(template).not_to be_valid
    end
  end
end
