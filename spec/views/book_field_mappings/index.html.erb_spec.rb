# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_field_mappings/index', type: :view do
  before(:each) do
    assign(:book_field_mappings, [
             BookFieldMapping.create!(display_name: 'EAN', lookup_field: 'ean'),
             BookFieldMapping.create!(display_name: 'ISBN', lookup_field: 'isbn')
           ])
  end

  it 'renders a list of book_field_mappings' do
    render

    within 'table' do
      expect(rendered).to have_text 'Display Name'
      expect(rendered).to have_text 'Lookup Field'
      expect(rendered).to have_text 'Created At'
      expect(rendered).to have_text 'Updated At'
      expect(rendered).to have_text 'Action'
    end
    expect(rendered).to have_css('a[href="/book_field_mappings/new"]')
    assert_select 'table>tbody>tr', count: 2
  end
end
