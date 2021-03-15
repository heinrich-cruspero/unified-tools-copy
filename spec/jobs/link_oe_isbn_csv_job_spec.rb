# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkOeIsbnCsvJob, type: :job do
  fixtures :books

  let(:header) { 'isbn, oe_isbn' }
  let(:row1) { '0521448077, 1002171856' }
  let(:row2) { '0130224847, 1004334523' }
  let(:row3) { '0230224869, 1004723570' }
  let(:row4) { '0307238024, 1005991331' }
  let(:row5) { '0394309790, 1006394841' }
  let(:rows) { [header, row1, row2, row3, row4, row5] }

  let(:csv_file_path) { 'tmp/link_oe_isbn.csv' }
  let!(:csv) do
    CSV.open(csv_file_path, 'w') do |csv|
      rows.each do |row|
        csv << row.split(',')
      end
    end
  end

  describe '#perform_later' do
    it 'processes link oe isbn job' do
      csv_text = File.read(csv_file_path)
      csv_data = CSV.parse(csv_text, headers: true).map(&:to_h)

      expect do
        described_class.perform_later(csv_data)
      end.to have_performed_job(described_class)

      csv_data.each do |row|
        isbn = row['isbn']
        oe_isbn = row['oe_isbn']
        book = Book.find_by(isbn: isbn)
        expect(book.oe_isbn).to eq oe_isbn
      end
    end
  end
end
