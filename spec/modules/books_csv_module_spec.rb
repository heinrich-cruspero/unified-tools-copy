# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksCsvModule do
  include BooksCsvModule

  let(:header) { 'isbn,ean,title,author,edition,publisher' }
  let(:row1) { '0000000001,1000000000001,The Couple in the Widow,CAMERON HOLMES,1,Bookends' }
  let(:row2) { '0000000002,2000000000002,Miss Minnie And The Bees,LOREN FULLER,2,Bound Books' }
  let(:row3) { '0000000003,3000000000003,Gone Town,REGAN SOWLE,3,Find Your Bind' }
  let(:rows) { [header, row1, row2, row3] }

  let(:csv_file_path) { 'tmp/add_manual_isbn_valid.csv' }
  let(:invalid_csv_file_path) { 'tmp/add_manual_isbn_invalid.csv' }
  let!(:csv) do
    CSV.open(csv_file_path, 'w') do |csv|
      rows.each do |row|
        csv << row.split(',')
      end
    end
  end
  let!(:csv_data) { File.read(csv_file_path) }

  it 'validates headers' do
    csv = CSV.parse(csv_data, headers: true)
    is_valid = validate_headers(csv.headers)
    expect(is_valid).to eq true
  end

  it 'validates entries' do
    csv = CSV.parse(csv_data, headers: true).map(&:to_h)
    is_valid, _err = validate_entries(csv)
    expect(is_valid).to eq true
  end

  it 'returns false on invalid headers' do
    csv = CSV.parse(csv_data, headers: true)
    is_valid = validate_headers(csv.headers.pop)
    expect(is_valid).to eq false
  end

  it 'returns false on invalid null fields' do
    csv = CSV.parse(csv_data, headers: true).map(&:to_h)
    csv.first['publisher'] = nil
    is_valid, _err = validate_entries(csv)
    expect(is_valid).to eq false
  end

  after(:each) { File.delete(csv_file_path) }
end
