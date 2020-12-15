# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_export_templates/index', type: :view do
  let(:field_1) { create(:book_field_mapping, display_name: 'EAN', lookup_field: 'ean') }
  let(:field_2) { create(:book_field_mapping, display_name: 'ISBN', lookup_field: 'isbn') }
  let(:existing_template) { build(:book_export_template, name: 'template1') }
  before(:each) do
    template1 = BookExportTemplate.new(name: 'Template1')
    template1.book_export_template_field_mappings.build(
      position: 0,
      book_field_mapping_id: field_1.id
    ).save
    template2 = BookExportTemplate.new(name: 'Template2')
    template2.book_export_template_field_mappings.build(
      position: 0,
      book_field_mapping_id: field_2.id
    ).save
    assign(:book_export_templates, [template1, template2])
  end

  it 'renders a list of book_export_templates' do
    render

    within 'table' do
      expect(rendered).to have_text 'ID'
      expect(rendered).to have_text 'Name'
      expect(rendered).to have_text 'Fields'
      expect(rendered).to have_text 'Created At'
      expect(rendered).to have_text 'Updated At'
      expect(rendered).to have_text 'Action'
    end
    expect(rendered).to have_css('a[href="/book_export_templates/new"]')
    assert_select 'table>tbody>tr', count: 2
  end
end
