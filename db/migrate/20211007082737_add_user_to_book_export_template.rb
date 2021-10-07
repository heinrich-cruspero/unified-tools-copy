class AddUserToBookExportTemplate < ActiveRecord::Migration[6.0]
  def change
    add_reference :book_export_templates, :user, foreign_key: true
  end
end
