class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.index [:name], unique: true
      t.timestamps
    end

    create_table(:user_roles, :id => false) do |t|
      t.references :user, foreign_key: true
      t.references :role, foreign_key: true
    end

    add_index(:user_roles, 
      [ :user_id, :role_id ],
      unique: true,
      name: "index_user_roles"  
    )
  end
end
