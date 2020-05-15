# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe BooksController, type: :controller do
  before(:each) do
    sign_in create(:user)
  end

  valid_attributes = {
    author: Faker::Name.name,
    title: Faker::Name.name,
    edition: Faker::Name.name,
    publisher: Faker::Name.name,
    publication_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    weight: 1,
    isbn: Faker::Alphanumeric.alphanumeric(number: 10),
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
  }

  describe 'GET #index' do
    it 'returns a found response' do
      Book.create! valid_attributes
      get :index
      expect(response.code).to eq('302')
    end
  end
end
