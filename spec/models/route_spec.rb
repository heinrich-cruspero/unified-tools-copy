# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Route, type: :model do
  it 'is valid with valid attributes' do
    expect(Route.new).to be_valid
  end
end
