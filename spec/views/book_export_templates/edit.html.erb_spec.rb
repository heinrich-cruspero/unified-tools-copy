require 'rails_helper'

RSpec.describe "book_export_templates/edit", type: :view do
  before(:each) do
    @book_export_template = assign(:book_export_template, BookExportTemplate.create!(
      name: "MyString"
    ))
  end

  it "renders the edit book_export_template form" do
    render

    assert_select "form[action=?][method=?]", book_export_template_path(@book_export_template), "post" do

      assert_select "input[name=?]", "book_export_template[name]"
    end
  end
end
