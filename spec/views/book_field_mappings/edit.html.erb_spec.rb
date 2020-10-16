require 'rails_helper'

RSpec.describe "book_field_mappings/edit", type: :view do
  before(:each) do
    @book_field_mapping = assign(:book_field_mapping, BookFieldMapping.create!())
  end

  it "renders the edit book_field_mapping form" do
    render

    assert_select "form[action=?][method=?]", book_field_mapping_path(@book_field_mapping), "post" do
    end
  end
end
