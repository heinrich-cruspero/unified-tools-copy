# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkOeIsbnCsvJob, type: :job do
  let(:csv_data) { [{ 'isbn' => '0521448077', 'oe_isbn' => '1002171856' }] }

  describe '#perform_later' do
    it 'processes link oe isbn job' do
      expect do
        described_class.perform_later(csv_data)
      end.to have_performed_job(described_class)
    end
  end
end
