# frozen_string_literal: true

##
module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-danger'
    end
  end

  def link_to_add_fields(name, form, association)
    obj = form.object.send(association).klass.new
    id = obj.object_id
    fields = form.fields_for(association, obj, child_index: id) do |builder|
      render(association.to_s, f: builder)
    end

    link_to(name, '#', class: 'add_fields btn btn-secondary btn-sm',
                       data: { id: id, fields: fields.gsub("\n", '') })
  end
end
