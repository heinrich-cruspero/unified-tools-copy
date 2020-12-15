# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_field_mappings/new', type: :view do
  before(:each) do
    assign(:book_field_mapping, BookFieldMapping.new(display_name: 'EAN', lookup_field: 'ean'))
  end

  it 'renders new book_field_mapping form' do
    render

    expect(rendered).to have_css('form[action="/book_field_mappings"]')
    expect(rendered).to have_selector('input#book_field_mapping_display_name')
    expect(rendered).to have_selector('input#book_field_mapping_lookup_field')
  end
end
