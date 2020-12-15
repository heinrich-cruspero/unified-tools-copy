# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_field_mappings/show', type: :view do
  before(:each) do
    @book_field_mapping = assign(:book_field_mapping, BookFieldMapping.create!(
                                                        display_name: 'EAN', lookup_field: 'ean'
                                                      ))
  end

  it 'renders attributes' do
    render
    within 'table' do
      expect(rendered).to have_text 'ID'
      expect(rendered).to have_text 'Display Name'
      expect(rendered).to have_text 'Lookup Field'
      expect(rendered).to have_text 'Created At'
      expect(rendered).to have_text 'Updated At'
    end
    assert_select 'table>tbody>tr', count: 5
    assert_select 'a', count: 4
    expect(rendered).to match(/Name/)
  end
end
