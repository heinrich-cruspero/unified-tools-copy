class CreateBookExportTemplateFieldMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :book_export_template_field_mappings do |t|
      t.integer :book_export_template_id
      t.integer :book_field_mapping_id

      t.timestamps
    end
  end
end
