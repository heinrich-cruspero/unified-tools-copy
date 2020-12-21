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
      amazon_order_id: {
        source: 'AmazonOrder.amazon_order_id',
        cond: :string_eq
      },
      status: {
        source: 'AmazonOrder.status',
        cond: :string_eq
      },
      state: {
        source: 'AmazonOrder.state',
        cond: :string_eq
      },
      city: {
        source: 'AmazonOrder.city',
        cond: :string_eq
      },
      zipcode: {
        source: 'AmazonOrder.zipcode',
        cond: :string_eq
      },
      country_code: {
        source: 'AmazonOrder.country_code',
        cond: :string_eq
      },
      order_total: {
        source: 'AmazonOrder.order_total',
        searchable: false
      },
      purchase_date: {
        source: 'AmazonOrder.purchase_date',
        searchable: false
      }
    }
  end

  def data
    records.map do |record|
      {
        amazon_order_id: record.amazon_order_id,
        status: record.status,
        state: record.state,
        city: record.city,
        zipcode: record.zipcode,
        country_code: record.country_code,
        order_total: record.order_total,
        purchase_date: record.purchase_date,
        amazon_order_item: link_to('Order Items', amazon_order_path(record),
                                   class: 'btn btn-info btn-sm')
      }
    end
  end

  def get_raw_records(*)
    AmazonOrder.index(params[:filters])
  end

  def record_map(record)
    {
      amazon_order_id: record.amazon_order_id,
      status: record.status,
      state: record.state,
      city: record.city,
      zipcode: record.zipcode,
      order_type: record.amazon_order_items&.pluck(:sale_type)&.join(''),
      order_total: record.order_total,
      purchase_date: record.purchase_date
    }
  end
end
