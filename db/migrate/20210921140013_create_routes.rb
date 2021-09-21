class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :path
      t.integer :feature_id

      t.index [:feature_id]
      t.timestamps
    end

    add_index :routes, [ :id, :feature_id ], unique: true
  end
end
