class CreateRouteActions < ActiveRecord::Migration[6.0]
  def change
    create_table :route_actions do |t|
      t.belongs_to :route, index: true
      t.integer :action, default: 0, null: false
      
      t.timestamps
    end

    create_table(:permission_route_actions) do |t|
      t.references :permission, foreign_key: true
      t.references :route_action, foreign_key: true
    end

    add_index :route_actions, [ :route_id, :action ], unique: true
    add_index(:permission_route_actions,
      [ :permission_id, :route_action_id ],
      unique: true,
      name: "index_permission_route_actions"
    )
  end
end
