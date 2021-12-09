# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'is valid with valid attributes' do
    expect(Role.new).to be_valid
  end
end
