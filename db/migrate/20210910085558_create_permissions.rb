class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.integer :authorizable_id
      t.string :authorizable_type

      t.integer :permissible_id
      t.string :permissible_type

      t.boolean :access_granted, default: false

      t.timestamps
    end

    add_index :permissions, 
              [ :name, :authorizable_type, :authorizable_id ], 
              unique: true,
              name: "index_permission_authorizable"
    add_index :permissions, [ :authorizable_type, :authorizable_id ]

    add_index :permissions, 
              [ :name, :permissible_type, :permissible_id ], 
              unique: true,
              name: "index_permission_permissible"
    add_index :permissions, [ :permissible_type, :permissible_id ]
  end
end
