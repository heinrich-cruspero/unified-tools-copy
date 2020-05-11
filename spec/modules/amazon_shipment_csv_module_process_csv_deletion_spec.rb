# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AmazonShipmentCsvModule do
  include AmazonShipmentCsvModule

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
    process_delete processed
  end

  it 'tests process method' do
    amazon_shipment = FactoryBot.create(:amazon_shipment)

    IndabaSku.create(
      sku: 'ABC-227-04929',
      amazon_shipment_id: amazon_shipment.id,
      quantity: 1
    )

    processed = SmarterCSV.process(file_path)
    process_delete processed
  end

  after(:each) { File.delete(file_path) }
end
