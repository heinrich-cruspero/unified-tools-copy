# frozen_string_literal: true

##
class BookDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      ean: { source: 'Book.ean', cond: :like, searchable: true, orderable: true },
      isbn: { source: 'Book.isbn' },
      author: { source: 'Book.author' },
      title: { source: 'Book.title' }
    }
  end

  def data
    records.map do |record|
      {
        ean: record.ean,
        isbn: record.isbn,
        author: record.author,
        title: record.title,
        edition: record.edition,
        subject: record.subject,
        publication_date: record.publication_date,
        copyright: record.copyright,
        publisher: record.publisher,
        edition_status_code: record.edition_status_code,
        edition_status_date: record.edition_status_date,
        grade: record.grade,
        list_price: record.list_price,
        used_wholesale_price: record.used_wholesale_price,
        max_wholesale_price: record.max_wholesale_price,
        trade_in: record.trade_in,
        lowest_price: record.lowest_price,
        sales_rank: record.sales_rank,
        sales_rank_aug_avg: record.sales_rank_aug_avg,
        amazon_rental: record.amazon_rental,
        lowest_rental: record.lowest_rental,
        fcb_price: record.fcb_price,
        fba_price: record.fba_price,
        updated_at: record.updated_at
      }
    end
  end

  def get_raw_records(*)
    # insert query here
    Book.all
  end
end
