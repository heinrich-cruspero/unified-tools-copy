# frozen_string_literal: true

namespace :permission do
  desc 'Create Permission Routes'

  task routes: :environment do |_t, _args|
    desc 'Usage: rails permission:routes'

    Rails.application.routes.routes.each do |route|
      excluded_routes = %i[rails devise omniauth active_storage action_mailbox]
      controller = route.defaults[:controller]
      action = route.defaults[:action]

      next if controller.nil?

      next if excluded_routes.any? { |r| controller.include? r.to_s }

      Route.find_or_create_by(
        controller_name: controller,
        action_name: action
      )
    end

    puts 'Created Permission Routes'
  end
end
