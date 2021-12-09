class AddUserToBookExportTemplate < ActiveRecord::Migration[6.0]
  def up
    add_reference :book_export_templates, :user, foreign_key: true, null: true
    
    user = User.find_by(email: 'jmartin@bba-corp.com')
    BookExportTemplate.all.each do |template|
      template.user = user
      template.save!
    end

    change_column_null :book_export_templates, :user_id, false
  end

  def down
    remove_reference :book_export_templates, :user, foreign_key: true
  end
end
