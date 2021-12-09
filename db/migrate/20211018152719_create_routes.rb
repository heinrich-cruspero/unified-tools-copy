class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :controller_name
      t.string :action_name

      t.index [:controller_name]
      t.index [:action_name]
      t.timestamps
    end

    create_table(:feature_routes) do |t|
      t.references :feature, foreign_key: true
      t.references :route, foreign_key: true
    end

    add_index(:feature_routes,
      [ :feature_id, :route_id ],
      unique: true,
      name: "index_feature_routes"
    )
  end
end
