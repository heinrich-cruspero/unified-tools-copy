# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Book.column_names[1..].each do |item|
  next if BookFieldMapping.where(lookup_field: item).exists?

  BookFieldMapping.find_or_create_by(
    display_name: item.upcase,
    lookup_field: item
  )
  puts "Created book field mapping: #{item}"
end
