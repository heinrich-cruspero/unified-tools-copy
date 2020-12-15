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
    s3 = Aws::S3::Resource.new(region:
                                   Rails.application.credentials[Rails.env.to_sym][:aws][:region])
    bucket = Rails.application.credentials[Rails.env.to_sym][:aws][:bucket_name]

    key = "downloads/#{user_id}/#{Time.now}/#{file_name}"
    obj = s3.bucket(bucket).object(key)

    obj.upload_stream(tempfile: true) do |write_stream|
      write_stream << CSV.generate_line(datatable.view_columns.keys)
      datatable.records.find_each do |order_item|
        record_map = datatable.record_map(order_item)

        write_stream << CSV.generate_line(record_map.values)
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
end
