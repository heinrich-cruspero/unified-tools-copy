# frozen_string_literal: true

require 'will_paginate'

##
class Submission < ApplicationRecord
  self.per_page = 10

  belongs_to :user

  validates :company_name, :seller_name, :quantity, :isbn,
            :source_name, :source_address, :source_phone, 
            :source_email, presence: true

  enum status: ['pending', 'whitelisted', 'blacklisted']

  def self.admin_index(params)
    submissions = Submission.all
    approved = params[:approved]
    statuses = params[:status]
    
    if !approved.empty?
      submissions = submissions.where(approved: approved)
    end

    unless statuses.blank?
      submissions = submissions.where(status: statuses)
    end
    
    submissions
  end

  def self.user_search(search_term)
    results = none

    unless search_term.nil? || search_term.empty?
      results = Submission.where(approved: true)
                .where('company_name iLIKE :search_term OR seller_name iLIKE :search_term', {:search_term => "%#{search_term}%"})
                .order(:company_name)
    end
    results
  end
end
