require 'rails_helper'

RSpec.describe "amazon_shipments/index", type: :view do
  before(:each) do
    @amazon_shipments = WillPaginate::Collection.new(4,10,0)
    2.times do |index|
      @amazon_shipments << AmazonShipment.create!(:isbn => "Isbn #{index}",
                                                  :shipment_id => "Shipment",
                                                  :quantity_shipped => 2,
                                                  :quantity_in_case => 3,
                                                  :quantity_received => 4,
                                                  :reconciled => false)
    end
    assign(:test, @amazon_shipments) # for will_paginate
    assign(:amazon_shipment_items, @amazon_shipments)
  end

  it "renders a list of amazon_shipments" do
    render
    assert_select "tr>td", :text => "Isbn 0".to_s, :count => 1
    assert_select "tr>td", :text => "Isbn 1".to_s, :count => 1
    assert_select "tr>td", :text => "Shipment".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td>span", :text => "No", :count => 2
  end
end
