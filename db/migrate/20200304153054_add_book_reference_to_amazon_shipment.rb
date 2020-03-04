class AddBookReferenceToAmazonShipment < ActiveRecord::Migration[6.0]
  def change
    add_reference :amazon_shipments, :book, foreign_key: true, null: true
  end
end
