# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

custom_columns = BookFieldMapping.custom_columns
column_names = Book.column_names[1..]
column_names.push(*custom_columns)
column_names.each do |item|
  BookFieldMapping.find_or_create_by(
    display_name: item.upcase,
    lookup_field: item
  )
end

puts 'Created Book Field Mappings.'

%i[User Admin StoreManager SuperAdmin].each do |role|
  Role.find_or_create_by(
    name: role
  )
end
