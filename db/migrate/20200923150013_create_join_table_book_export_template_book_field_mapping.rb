class CreateJoinTableBookExportTemplateBookFieldMapping < ActiveRecord::Migration[6.0]
  def change
    create_join_table :book_export_templates, :book_field_mappings do |t|
      t.index [:book_export_template_id, :book_field_mapping_id], name: 'index_book_export_template_on_field_mapping_id'
      t.index [:book_field_mapping_id, :book_export_template_id], name: 'index_field_mapping_book_on_export_template_id'
    end
  end
end
