class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.integer :authorizable_id
      t.string :authorizable_type
      t.integer :permissible_id
      t.string :permissible_type

      t.timestamps
    end

    add_index :permissions, 
              [:authorizable_id, :authorizable_type, 
                :permissible_id, :permissible_type],
              unique: true,
              name: "index_permissions"
  end
end
