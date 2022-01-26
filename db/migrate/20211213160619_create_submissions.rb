class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.references :user, foreign_key: true
      t.string :company_name, null: false
      t.string :seller_name, null: false
      t.integer :quantity, null: false, default: 0
      t.string :isbn, null: false
      t.boolean :counterfeits
      t.string :source_name, null: false
      t.string :source_address, null: false
      t.string :source_phone, null: false
      t.string :source_email, null: false
      t.text :notes
      t.boolean :approved, default: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
