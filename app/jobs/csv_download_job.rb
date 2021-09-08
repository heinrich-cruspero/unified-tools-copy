# frozen_string_literal: true

##
class CsvDownloadJob < ApplicationJob
  queue_as :default

  def priority
    -1
  end

  def perform(*args)
    params = args[0]
    datatable_class = args[1]
    file_name = args[2]
    user_id = args[3]

    params[:length] = '-1'
    params = ActionController::Parameters.new(params)
    datatable = datatable_class.constantize.send('new', params)
    s3 = Aws::S3::Resource.new(
      region: Rails.application.credentials[Rails.env.to_sym][:unified_s3][:region]
    )
    bucket = Rails.application.credentials[Rails.env.to_sym][:unified_s3][:bucket_name]

    key = "downloads/#{user_id}/#{Time.now}/#{file_name}"
    obj = s3.bucket(bucket).object(key)

    obj.upload_stream(tempfile: true) do |write_stream|
      write_stream << CSV.generate_line(datatable.view_columns.keys)
      if datatable_class == 'BookExportDatatable'
        generate_book_export_csv(params, datatable, write_stream)
      else
        datatable.records.each do |order_item|
          record_map = datatable.record_map(order_item)
          write_stream << CSV.generate_line(record_map.values)
        end
      end
    end

    url = obj.presigned_url(:get,
                            { expires_in: 30,
                              response_content_disposition: "attachment;  filename=#{file_name}" })

    ActionCable.server.broadcast(
      "file_download_channel:#{user_id}",
      download_url: url
    )
  end

  def generate_book_export_csv(params, datatable, write_stream)
    book_ids = params[:ids]
    book_id_type = params[:book_id]
    keys = datatable.template_keys

    col_count = keys.count
    empty_line = Array.new(col_count)
    id_in_fields = keys.include?(book_id_type.to_sym)
    id_index = id_in_fields ? keys.index(book_id_type.to_sym) : nil

    records = {}
    datatable.records.each do |record|
      records[record.send(book_id_type)] = record
    end

    book_ids.each do |id|
      if records[id]
        record_map = datatable.record_map(records[id])
        write_stream << CSV.generate_line(record_map.values)
      else
        id_index ? empty_line[id_index] = id : empty_line
        write_stream << CSV.generate_line(empty_line)
      end
    end
  end
end
