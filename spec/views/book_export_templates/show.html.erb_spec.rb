# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_export_templates/show', type: :view do
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
    @book_export_template = assign(:book_export_template, template)
  end

  it 'renders attributes' do
    render
    within 'table' do
      expect(rendered).to have_text 'ID'
      expect(rendered).to have_text 'Name'
      expect(rendered).to have_text 'Fields'
      expect(rendered).to have_text 'Created At'
      expect(rendered).to have_text 'Updated At'
    end
    assert_select 'table>tbody>tr', count: 5
    assert_select 'a', count: 5
    expect(rendered).to match(/Name/)
  end
end
