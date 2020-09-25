require 'rails_helper'

RSpec.describe "book_export_templates/index", type: :view do
  before(:each) do
    assign(:book_export_templates, [
      BookExportTemplate.create!(
        name: "Name"
      ),
      BookExportTemplate.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of book_export_templates" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
