class CreateRouteActions < ActiveRecord::Migration[6.0]
  def change
    create_table :route_actions do |t|
      t.belongs_to :route, index: true
      t.integer :action, default: 0, null: false
      
      t.timestamps
    end

    add_index :route_actions, [ :id, :route_id ], unique: true
  end
end
