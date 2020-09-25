class CreateBookFieldMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :book_field_mappings do |t|
      t.string :display_name
      t.string :lookup_field

      t.timestamps
    end
  end
end
