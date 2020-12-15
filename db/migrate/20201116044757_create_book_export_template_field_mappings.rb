class CreateBookExportTemplateFieldMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :book_export_template_field_mappings do |t|
      t.references :book_export_template, index: {name: "book_export_template_index"}, foreign_key: true
      t.references :book_field_mapping, index: {name: "book_field_mappings_index"}, foreign_key: true
      t.integer :position, index: true, null: false, default: 0

      t.timestamps
    end
    add_index :book_export_template_field_mappings, 
              ["book_export_template_id", "book_field_mapping_id"], 
              unique: true,
              name: "index_book_export_template_field_mappings"
  end
end
