class CreateBookExportTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :book_export_templates do |t|
      t.string :name, null: false
      t.index [:name], unique: true
      t.timestamps
    end
  end
end
