class UpdateBookExportTemplatesChangeNameColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_null :book_export_templates, :name, false
    add_index :book_export_templates, :name
  end
end
