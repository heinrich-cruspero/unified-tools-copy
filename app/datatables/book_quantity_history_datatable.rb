# frozen_string_literal: true

##
class BookQuantityHistoryDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    # TODO
    @view_columns ||= {
      price: { source: 'Book.list_price' },
      day: { source: 'Book.qa_aug_rank' }
    }
  end

  def data
    records.map do |record|
      {
        price: record.list_price,
        day: record.qa_aug_rank
      }
    end
  end

  def get_raw_records(*)
    Book.search_ean_isbn(params[:id])
  end
end
