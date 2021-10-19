# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'book_export_templates/index', type: :view do
  
  before(:each) do
    template = BookExportTemplate.new(name: 'Template')
    template.book_export_template_field_mappings.build(
      position: 0,
      book_field_mapping_id: field_1.id
    ).save
    assign(:book_export_template, template)
    @book_export_template = assign(:book_export_template, template)
  end
end

RSpec.describe 'book_export_templates/index', type: :feature do
  fixtures :roles

  let(:field_1) { create(:book_field_mapping, display_name: 'EAN', lookup_field: 'ean') }
  let(:field_2) { create(:book_field_mapping, display_name: 'ISBN', lookup_field: 'isbn') }
  let(:field_3) { create(:book_field_mapping, display_name: 'OE_ISBN', lookup_field: 'oe_isbn') }
  let(:existing_template) { build(:book_export_template, name: 'template1') }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    user = create(:user, :super_admin)

    template = BookExportTemplate.new(name: 'Template', user: user)
    template.book_export_template_field_mappings.build(
      position: 0,
      book_field_mapping_id: field_1.id
    ).save
    login_as(user, scope: :user)
  end

  scenario '#index page' do
    visit book_export_templates_path
    expect(page).to have_content('Book Export Templates')
  end
end
