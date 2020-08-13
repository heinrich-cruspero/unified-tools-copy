class AddNewFieldsToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :valore_low, :decimal,  precision: 10, scale: 2
    add_column :books, :valore_rent, :decimal,  precision: 10, scale: 2
    add_column :books, :yearly_main_sold_price, :decimal,  precision: 10, scale: 2
    add_column :books, :yearly_fbaz_sold_price, :decimal,  precision: 10, scale: 2
    add_column :books, :yearly_fbaz_rented_price, :decimal,  precision: 10, scale: 2
    add_column :books, :rent_avg, :decimal,  precision: 10, scale: 2
  end
end
