class ProcessCsvJob < ApplicationJob
  include AmazonShipmentCsvModule
  queue_as :delayed_job

  def perform(uploaded_file)
    process_csv uploaded_file
  end
  # handle_asynchronously :perform

end