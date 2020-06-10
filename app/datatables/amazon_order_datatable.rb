# frozen_string_literal: true

##
class AmazonOrderDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to, :amazon_order_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      order_total: {
        source: 'AmazonOrder.order_total',
        searchable: false,
        orderable: true
      },
      purchase_date: {
        source: 'AmazonOrder.purchase_date',
        searchable: false,
        orderable: true
      },
      status: {
        source: 'AmazonOrder.status',
        cond: :string_in,
        searchable: true,
        orderable: true
      },
      amazon_order_id: {
        source: 'AmazonOrder.amazon_order_id',
        cond: :string_in,
        searchable: true,
        orderable: true
      },
      state: {
        source: 'AmazonOrder.state',
        cond: :string_in,
        searchable: true,
        orderable: true
      },
      city: {
        source: 'AmazonOrder.city',
        cond: :string_in,
        searchable: true,
        orderable: true
      },
      zipcode: {
        source: 'AmazonOrder.zipcode',
        cond: :string_in,
        searchable: true,
        orderable: true
      }
    }
  end

  def data
    records.map do |record|
      {
        order_total: record.order_total,
        purchase_date: record.purchase_date,
        status: record.status,
        amazon_order_id: record.amazon_order_id,
        state: record.state,
        city: record.city,
        zipcode: record.zipcode,
        amazon_order_item: link_to('Order Items', amazon_order_path(record), class: 'btn btn-info btn-sm')
      }
    end
  end

  def get_raw_records(*)
    # insert query here
    AmazonOrder.all
  end
end
