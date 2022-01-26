# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Submission, type: :model do
  let(:user) { create(:user) }
  let(:submission) { create(:submission, user: user) }

  it 'is valid with valid attributes' do
    expect(submission).to be_valid
  end

  it 'validates required attributes' do
    submission.company_name = nil
    expect(submission).not_to be_valid
  end
end
