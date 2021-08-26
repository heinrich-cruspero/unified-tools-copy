# frozen_string_literal: true

##
require 'rails_helper'

RSpec.describe 'GuideImports', type: :request do
    describe 'GET/guide_imports' do
        it 'redirects to guides imports index page' do
            get guide_imports_path
            expect(response).to have_http_status(302)
        end

        it 'redirects to guide imports new page' do
            get new_guide_import_path
            expect(response).to have_http_status(302)
        end
    end
end
