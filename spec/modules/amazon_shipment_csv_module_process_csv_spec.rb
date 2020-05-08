# frozen_string_literal: true

require 'rails_helper'
include AmazonShipmentCsvModule

RSpec.describe AmazonShipmentCsvModule do
  let(:header) { 'ISBN, AZ SKU, Qty, Ship ID, SKU, Condition' }
  let(:row2) { '801027888, TI3P:0801027888:GOOD:RTEXT, 1, FBA15JRZQD8S, ABC-227-04929, Used - Good' }
  let(:row3) { '801027889, TI3P:0801027888:GOOD:RTEXT, 1, FBA15JRZQD8S, ABC-227-04929, Used - Good' }
  let(:rows) { [header, row2, row3] }

  let(:file_path) { 'tmp/test_2020-05-08.csv' }
  let!(:csv) do
    CSV.open(file_path, 'w') do |csv|
      rows.each do |row|
        csv << row.split(',')
      end
    end
  end

  it 'tests process method' do
    Book.create(
      author: Faker::Name.name,
      title: Faker::Name.name,
      edition: Faker::Name.name,
      publisher: Faker::Name.name,
      publication_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
      weight: 1,
      isbn: '801027888',
      edition_status_code: 1,
      edition_status_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
      list_price: 1,
      used_wholesale_price: 1,
      nebraska_wh: 1,
      qa_aug_low: 1,
      lowest_good_price: 1,
      qa_low: 1,
      yearly_low: 1,
      qa_fba_low: 1,
      monthly_sqf: 1,
      monthly_spf: 1,
      monthly_rqf: 1,
      monthly_rpf: 1,
      one_year_highest_wholesale_price: 1,
      two_years_wh_max: 1
    )

    processed = SmarterCSV.process(file_path)
    process_csv processed, file_path
  end

  after(:each) { File.delete(file_path) }
end
