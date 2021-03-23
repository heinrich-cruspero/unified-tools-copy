class AddCurrencyConvertedToAmazonOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :amazon_orders, :currency_converted, :boolean, default: false, null: false
  end
end
