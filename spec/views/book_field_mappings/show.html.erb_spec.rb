require 'rails_helper'

RSpec.describe "book_field_mappings/show", type: :view do
  before(:each) do
    @book_field_mapping = assign(:book_field_mapping, BookFieldMapping.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
