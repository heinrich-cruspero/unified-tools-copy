require 'rails_helper'

RSpec.describe "book_field_mappings/new", type: :view do
  before(:each) do
    assign(:book_field_mapping, BookFieldMapping.new())
  end

  it "renders new book_field_mapping form" do
    render

    assert_select "form[action=?][method=?]", book_field_mappings_path, "post" do
    end
  end
end
