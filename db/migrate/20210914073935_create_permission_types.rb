class CreatePermissionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :permission_types do |t|
      t.string :name
      t.string :description
      t.index [:name], unique: true
      t.timestamps
    end
  end
end
