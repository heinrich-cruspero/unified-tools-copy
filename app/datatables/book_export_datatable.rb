# frozen_string_literal: true

##
class BookExportDatatable < AjaxDatatablesRails::ActiveRecord
  def initialize(params)
    super
    @display_name_keys = {}
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
      record_mappings.store(item.to_sym, record.send(item))
    end
    record_mappings
  end

  def template_keys
    attributes = %w[]
    template = BookExportTemplate.find(params[:id])
    template.book_field_mappings.each do |field|
      attributes << field.lookup_field.to_sym
      @display_name_keys[field.lookup_field.to_sym] = field.display_name
    end
    attributes
  end

  def template_columns
    cols = {}
    @template_keys.each do |attr|
      display_name = @display_name_keys[attr]
      cols[display_name] = { source: "Book.#{attr}" }
    end
    cols
  end
end
