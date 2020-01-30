require 'rails_helper'

RSpec.describe 'Hello world', type: :feature do
  scenario 'index page' do
    visit amazon_shipments_path
    expect(page).to have_content('Sign in with Google')
  end
end