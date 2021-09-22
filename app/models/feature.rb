# frozen_string_literal: true

##
class Feature < ApplicationRecord
  has_many :routes

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
