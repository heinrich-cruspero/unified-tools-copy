# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_export_templates/show', type: :view do
  before(:each) do
    @book_export_template = assign(:book_export_template, BookExportTemplate.create!(
                                                            name: 'Name'
                                                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
