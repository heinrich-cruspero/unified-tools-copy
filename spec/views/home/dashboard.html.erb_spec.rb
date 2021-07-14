# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/dashboard.html.erb', type: :view do
  it 'renders dashboard' do
    render

    expect(rendered).to have_text 'Dashboard'
  end
end
