class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.integer :authorizable_id
      t.string :authorizable_type

      t.index [:name], unique: true
      t.timestamps
    end

    create_table(:book_field_mapping_permissions) do |t|
      t.references :permission, foreign_key: true
      t.references :book_field_mapping, foreign_key: true
    end

    add_index :permissions, 
              [ :name, :authorizable_type, :authorizable_id ], 
              unique: true,
              name: "index_permission_authorizable"
    add_index :permissions, [ :authorizable_type, :authorizable_id ],
              unique: true

    add_index(:book_field_mapping_permissions,
      [ :permission_id, :book_field_mapping_id ],
      unique: true,
      name: "index_book_field_mapping_permissions"
    )
  end
end
