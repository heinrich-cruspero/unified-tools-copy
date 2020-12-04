# frozen_string_literal: true

##
class BookFieldMapping < ApplicationRecord
  has_many :book_export_template_field_mappings,
           inverse_of: :book_field_mapping,
           foreign_key: 'book_field_mapping_id'
  has_many :book_export_templates, through: :book_export_template_field_mappings
  validates :display_name, :lookup_field, presence: true, uniqueness: true
  validate :field_belongs_to_book

  def self.custom_columns
    %w[company max_wh oe_aug_rank oe_list_price oe_two_years_wh_max
       oe_one_year_highest_wholesale_price oe_yearly_fbaz_rented_quantity
       oe_yearly_fbaz_sold_quantity oe_yearly_main_sold_quantity
       amazon_orders_7ds amazon_orders_30ds amazon_orders_90ds
       amazon_orders_180ds_sale amazon_orders_180ds_rental]
  end

  private

  def field_belongs_to_book
    if Book.column_names.include?(lookup_field) ||
       BookFieldMapping.custom_columns.include?(lookup_field)
      nil
    else
      errors.add(:lookup_field, "<b>#{lookup_field}</b> does not belong to Book fields.")
    end
  end
end
