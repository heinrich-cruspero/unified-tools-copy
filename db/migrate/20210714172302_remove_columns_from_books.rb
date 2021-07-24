class RemoveColumnsFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :peak_price, :decimal
    remove_column :books, :pnep, :date
    remove_column :books, :fba_august_average, :decimal
    remove_column :books, :wantlist_qty, :integer
    remove_column :books, :trade_in, :decimal
    remove_column :books, :lowest_rental_august_average, :decimal
    remove_column :books, :life, :decimal    

    BookExportTemplate.includes(:book_field_mappings).where(
        "book_field_mappings.lookup_field" => %w(
            pnep 
            peak_price 
            fba_august_average
            wantlist_qty
            trade_in 
            lowest_rental_august_average
            life
          )
        ).destroy_all

    BookFieldMapping.where(lookup_field: [
      'peak_price',
      'pnep',
      'fba_august_average',
      'wantlist_qty',
      'trade_in',
      'lowest_rental_august_average',
      'life'
    ]).destroy_all
  end
end
