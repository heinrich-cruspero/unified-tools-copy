# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'requests/spec_helper'

RSpec.describe ApplicationPolicy do
  subject { ApplicationPolicy.new(user, amazon_shipment) }

  let(:amazon_shipment) do
    FactoryBot.create(:amazon_shipment)
  end

  context 'for a visitor' do
    let(:user) { FactoryBot.create(:user) }
    it { should_not permit(:edit) }
    it { should_not permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:destroy) }
  end
end
