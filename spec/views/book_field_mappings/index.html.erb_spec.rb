require 'rails_helper'

RSpec.describe "book_field_mappings/index", type: :view do
  before(:each) do
    assign(:book_field_mappings, [
      BookFieldMapping.create!(),
      BookFieldMapping.create!()
    ])
  end

  it "renders a list of book_field_mappings" do
    render
  end
end
