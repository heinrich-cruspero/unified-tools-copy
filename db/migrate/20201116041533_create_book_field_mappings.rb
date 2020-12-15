class CreateBookFieldMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :book_field_mappings do |t|
      t.string :display_name, null: false
      t.string :lookup_field, null: false
      t.index [:display_name], unique: true
      t.index [:lookup_field], unique: true
      t.timestamps
    end
  end
end
