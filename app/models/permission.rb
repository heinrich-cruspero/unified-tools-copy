# frozen_string_literal: true

##
class Permission < ApplicationRecord
    belongs_to :authorizable,
                :polymorphic => true,
                :optional => true
    
    belongs_to :permissible,
                :polymorphic => true,
                :optional => true
end
