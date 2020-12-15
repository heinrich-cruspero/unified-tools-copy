# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_export_templates/new', type: :view do
  let(:field_1) { create(:book_field_mapping, display_name: 'EAN', lookup_field: 'ean') }
  let(:field_2) { create(:book_field_mapping, display_name: 'ISBN', lookup_field: 'isbn') }
  let(:field_3) { create(:book_field_mapping, display_name: 'OE_ISBN', lookup_field: 'oe_isbn') }
  let(:existing_template) { build(:book_export_template, name: 'template1') }
  before(:each) do
    template = BookExportTemplate.new(name: 'Template')
    template.book_export_template_field_mappings.build(
      position: 0,
      book_field_mapping_id: field_1.id
    ).save
    assign(:book_export_template, template)
  end

  it 'renders new book_export_template form' do
    render

    expect(rendered).to have_selector('form#export_template_form')
    expect(rendered).to have_selector('input#book_export_template_name')
    expect(rendered).to have_selector('select.field-select')
    expect(rendered).to have_selector('a.remove_fields')
  end
end
