require 'rails_helper'

RSpec.describe "amazon_shipments/index", type: :view do
  before(:each) do
    assign(:amazon_shipments, [
      AmazonShipment.create!(
        :isbn => "Isbn",
        :shipment_id => "Shipment",
        :quantity_shipped => 2,
        :quantity_in_case => 3,
        :quantity_received => 4,
        :reconciled => false
      ),
      AmazonShipment.create!(
        :isbn => "Isbn",
        :shipment_id => "Shipment",
        :quantity_shipped => 2,
        :quantity_in_case => 3,
        :quantity_received => 4,
        :reconciled => false
      )
    ])
  end

  it "renders a list of amazon_shipments" do
    render
    assert_select "tr>td", :text => "Isbn".to_s, :count => 2
    assert_select "tr>td", :text => "Shipment".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
