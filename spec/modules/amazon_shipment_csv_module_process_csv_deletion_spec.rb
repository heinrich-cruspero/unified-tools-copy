# frozen_string_literal: true

require 'rails_helper'
include AmazonShipmentCsvModule

RSpec.describe AmazonShipmentCsvModule do
  let(:header) { 'SKU' }
  let(:row2) { 'ABC-227-04929' }
  let(:rows) { [header, row2] }

  let(:file_path) { 'tmp/test.csv' }
  let!(:csv) do
    CSV.open(file_path, 'w') do |csv|
      rows.each do |row|
        csv << row.split(',')
      end
    end
  end

  it 'tests process method' do
    processed = SmarterCSV.process(file_path)
    process_csv_deletion processed
  end

  it 'tests process method' do
    amazon_shipment = FactoryBot.create(:amazon_shipment)

    IndabaSku.create(
      sku: 'ABC-227-04929',
      amazon_shipment_id: amazon_shipment.id,
      quantity: 1
    )

    processed = SmarterCSV.process(file_path)
    process_csv_deletion processed
  end

  after(:each) { File.delete(file_path) }
end