# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_export_templates/edit', type: :view do
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
    @book_export_template = assign(:book_export_template, template)
  end

  it 'renders the edit book_export_template form' do
    render

    assert_select 'form[action=?][method=?]',
                  book_export_template_path(@book_export_template), 'post' do
      assert_select 'input[name=?]', 'book_export_template[name]'
      assert_select 'select.field-select', count: 1
    end
  end
end
