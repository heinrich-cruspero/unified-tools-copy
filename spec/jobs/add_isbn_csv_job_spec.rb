# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddIsbnCsvJob, type: :job do
  let(:header) { 'isbn,ean,title,author,edition,publisher' }
  let(:row1) { '0000000001,1000000000001,The Couple in the Widow,CAMERON HOLMES,1,Bookends' }
  let(:row2) { '0000000002,2000000000002,Miss Minnie And The Bees,LOREN FULLER,2,Bound Books' }
  let(:row3) { '0000000003,3000000000003,Gone Town,REGAN SOWLE,3,Find Your Bind' }
  let(:rows) { [header, row1, row2, row3] }

  let(:csv_file_path) { 'tmp/add_manual_isbn.csv' }
  let!(:csv) do
    CSV.open(csv_file_path, 'w') do |csv|
      rows.each do |row|
        csv << row.split(',')
      end
    end
  end

  describe '#perform_later' do
    it 'processes add isbns job' do
      csv_text = File.read(csv_file_path)
      csv_data = CSV.parse(csv_text, headers: true).map(&:to_h)

      expect do
        described_class.perform_later(csv_data)
      end.to have_performed_job(described_class)

      csv_data.each do |row|
        isbn = row['isbn']
        book = Book.find_by(isbn: isbn)
        expect(book.nil?).to eq false
      end
    end
  end
end
