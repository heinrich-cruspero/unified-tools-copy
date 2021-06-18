class AddUploadedToS3ToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :uploaded_to_s3, :boolean, default: false, null: false
    add_index :books, :uploaded_to_s3
  end
end
