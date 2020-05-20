# frozen_string_literal: true

##
class AmazonOrderDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      order_total: { source: 'AmazonOrder.order_total', cond: :like, searchable: true, orderable: true },
      purchase_date: { source: 'AmazonOrder.purchase_date' },
      status: { source: 'AmazonOrder.status' }
    }
  end

  def data
    records.map do |record|
      {
        order_total: record.order_total,
        purchase_date: record.purchase_date,
        status: record.status
      }
    end
  end

  def get_raw_records(*)
    # insert query here
    AmazonOrder.all
  end
end
