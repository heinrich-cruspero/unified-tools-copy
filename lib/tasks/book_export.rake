# frozen_string_literal: true

##
# rubocop:disable  Metrics/BlockLength
namespace :book_export do
  desc 'Updates book export template field mapping display names.'

  task set_field_mapping_names: :environment do
    file = File.read("#{::Rails.root}/lib/assets/template_field_names.json")
    field_names = JSON.parse(file)
    
    book_field_mappings = BookFieldMapping.all
    book_field_mappings.each do |field|
      name = field_names[field.lookup_field]
      unless name.nil?
        field.update!(display_name: name)
        puts "Updated display name #{field.lookup_field}: #{name}"
      end
    end
  end

  task import_templates_from_outdaba: :environment do
    file = File.read("#{::Rails.root}/lib/assets/outdaba_templates.json")
    templates = JSON.parse(file)

    templates.each do |template|
      template_name = template['name']
      new_template = BookExportTemplate.new(name: template_name)
      fields = template['fields']
      fields.each do |field|
        field_name = field['name']
        field_position = field['position']
        field_mapping = BookFieldMapping.find_by(lookup_field: field_name)
        if field_mapping.nil?
          puts "Could not find Field Mapping: #{field_name} for template: #{template_name}"
          break
        else
          new_template.book_export_template_field_mappings.build(
            book_field_mapping_id: field_mapping.id,
            position: field_position
          )
        end
      end
      if new_template.save
        puts "Created template: #{new_template.name}"
      else
        puts "Failed to create template: #{template_name}, errors: #{new_template.errors.messages}"
      end
    end
  end
end
# rubocop:enable  Metrics/BlockLength
