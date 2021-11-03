class CreateRoles < ActiveRecord::Migration[6.0]
  def up
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

    %i[SuperAdmin Admin User StoreManager].each do |role|
      Role.find_or_create_by(
        name: role
      )
    end

    User.all.each do |user|
      user.roles << Role.where(name: "Admin")
    end
  end

  def down
    remove_index :user_roles, name: "index_user_roles"
    drop_table :user_roles
    drop_table :roles
  end
end
