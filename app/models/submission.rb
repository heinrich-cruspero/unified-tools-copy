# frozen_string_literal: true

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

    unless statuses.empty?
      submissions = submissions.where(status: statuses)
    end
    
    submissions
  end
end
