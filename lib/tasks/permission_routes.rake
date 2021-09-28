# frozen_string_literal: true

namespace :permission do
    desc 'Create Permission Routes'
  
    task :routes => :environment do |_t, args|
        desc 'Usage: rails permission:routes'
    
        # routes = Rails.application.routes.routes.map { 
        #     |r| {alias: r.name, path: r.path.spec.to_s, controller: r.defaults[:controller], action: r.defaults[:action]}
        # }
        
        Rails.application.routes.routes.each do |route|
            excluded_routes = %i[rails devise omniauth active_storage action_mailbox]
            controller = route.defaults[:controller]
            action = route.defaults[:action]
            
            unless controller.nil?
                Route.find_or_create_by(
                    controller_name: controller,
                    action_name: action
                ) if !excluded_routes.any? {|route| controller.include? route.to_s}
            end
        end

        puts 'Created Permission Routes'
    
    #   Rails.application.routes.routes.each do |route|
    #       puts route.defaults
    #   end
    end
  end
  