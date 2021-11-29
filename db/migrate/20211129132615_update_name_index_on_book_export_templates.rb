class UpdateNameIndexOnBookExportTemplates < ActiveRecord::Migration[6.0]
  def up
    remove_index :book_export_templates, [:name]
    add_index :book_export_templates, [:user_id, :name], unique: true
  end

  def down
    remove_index :book_export_templates, [:user_id, :name]
    add_index :book_export_templates, [:name], unique: true
  end
end
