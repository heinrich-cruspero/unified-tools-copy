# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AmazonOrdersController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:amazon_order_items) { create_list(:amazon_order_items, 5) }

  before(:each) do
    sign_in admin
  end

  describe '#index' do
    it 'without signin' do
      sign_out admin
      get :index

      expect(flash['alert']).to match('')
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end

    it 'shpuld match keys with json request' do
      get :index, params: { format: :json }
      res = JSON.parse(response.body)
      expect(res.keys).to contain_exactly('recordsTotal', 'recordsFiltered', 'data')
    end
  end
end
