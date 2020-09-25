require 'rails_helper'

RSpec.describe "book_export_templates/new", type: :view do
  before(:each) do
    assign(:book_export_template, BookExportTemplate.new(
      name: "MyString"
    ))
  end

  it "renders new book_export_template form" do
    render

    assert_select "form[action=?][method=?]", book_export_templates_path, "post" do

      assert_select "input[name=?]", "book_export_template[name]"
    end
  end
end
