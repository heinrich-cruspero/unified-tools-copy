require 'rails_helper'
include AmazonShipmentCsvModule

RSpec.describe AmazonShipmentCsvModule do
  let(:header) { "ISBN, AZ SKU, Qty, Ship ID, SKU, Condition" }
  let(:row2) { "801027888, TI3P:0801027888:GOOD:RTEXT, 1, FBA15JRZQD8S, ABC-227-04929, Used - Good"}
  let(:row3) { "801027889, TI3P:0801027888:GOOD:RTEXT, 1, FBA15JRZQD8S, ABC-227-04929, Used - Good"}
  let(:rows) { [header, row2, row3] }

  let(:file_path) { "tmp/test.csv" }
  let!(:csv) do
    CSV.open(file_path, "w") do |csv|
      rows.each do |row|
        csv << row.split(",")
      end
    end
  end


  it 'tests process method' do
    process_csv file_path
  end


  after(:each) { File.delete(file_path) }
end