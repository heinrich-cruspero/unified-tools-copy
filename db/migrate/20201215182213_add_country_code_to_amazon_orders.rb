class AddCountryCodeToAmazonOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_orders, :country_code, :string
    add_index :amazon_orders, :country_code
  end
end
