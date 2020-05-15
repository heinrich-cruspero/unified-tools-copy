# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with valid attributes' do
    expect(Book.new).to be_valid
  end
end
