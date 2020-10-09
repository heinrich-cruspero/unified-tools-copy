# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookExportTemplatesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/book_export_templates').to route_to('book_export_templates#index')
    end

    it 'routes to #new' do
      expect(get: '/book_export_templates/new').to route_to('book_export_templates#new')
    end

    it 'routes to #show' do
      expect(get: '/book_export_templates/1').to route_to('book_export_templates#show', id: '1')
    end

    it 'routes to #edit' do
      expect(
        get: '/book_export_templates/1/edit'
      ).to route_to(
        'book_export_templates#edit',
        id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/book_export_templates').to route_to('book_export_templates#create')
    end

    it 'routes to #update via PUT' do
      expect(
        put: '/book_export_templates/1'
      ).to route_to('book_export_templates#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/book_export_templates/1').to route_to('book_export_templates#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(
        delete: '/book_export_templates/1'
      ).to route_to('book_export_templates#destroy', id: '1')
    end
  end
end
