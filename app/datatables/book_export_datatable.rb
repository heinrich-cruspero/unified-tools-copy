# frozen_string_literal: true

##
class BookExportDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      ean: { source: 'Book.ean' },
      isbn: { source: 'Book.isbn' }
    }
  end

  def data
    records.map do |record|
      record_map(record)
    end
  end

  def get_raw_records(*)
    params[:book_id] == 'ean' ? Book.where(ean: params[:ids]) : Book.where(isbn: params[:ids])
  end

  def record_map(record)
    h = {}
    Book.column_names[1..].each do |item|
      h.store(item.to_sym, record[item])
    end
    h
  end
end
