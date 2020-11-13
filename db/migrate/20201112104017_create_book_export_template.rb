class CreateBookExportTemplate < ActiveRecord::Migration[6.0]
  def change
    create_table :book_export_templates do |t|
      t.string :name, null: false

      t.timestamps
    end
    
    create_table :book_field_mappings do |t|
      t.string :display_name
      t.string :lookup_field

      t.timestamps
    end
    create_table :book_export_template_field_mappings do |t|
      t.references :book_export_template, foreign_key: { to_table: 'book_export_templates' }, index: {name: "index_book_export_field_mappings_template"}
      t.references :book_field_mapping, foreign_key: { to_table: 'book_field_mappings' }, index: {name: "index_field_mappings_book_export_template"}

      t.timestamps
    end
    add_index :book_export_templates, :name
    add_index :book_field_mappings, :lookup_field, unique: true
  end
end
