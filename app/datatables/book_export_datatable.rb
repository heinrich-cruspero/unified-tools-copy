# frozen_string_literal: true

##
class BookExportDatatable < AjaxDatatablesRails::ActiveRecord
  def initialize(params)
    super
    @template_keys = template_keys
    @view_columns ||= template_columns
  end

  attr_reader :view_columns

  def data
    records.map do |record|
      record_map(record)
    end
  end

  def get_raw_records(*)
    params[:book_id] == 'ean' ? Book.where(ean: params[:ids]) : Book.where(isbn: params[:ids])
  end

  def record_map(record)
    record_mappings = {}
    @template_keys.each do |item|
      h.store(item.to_sym, record[item])
    end
    record_mappings
  end

  def template_keys
    attributes = %w[]
    template = BookExportTemplate.find(params[:template_id])
    template.book_field_mappings.each do |field|
      attributes << field.lookup_field.to_sym
    end
    attributes
  end

  def template_columns
    cols = {}
    @template_keys.each do |attr|
      cols[attr] = { source: "Book.#{attr}" }
    end
    cols
  end
end
