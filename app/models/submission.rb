# frozen_string_literal: true

##
class Submission < ApplicationRecord
  self.per_page = 10

  belongs_to :user

  validates :company_name, :seller_name, :quantity, :isbn,
            :source_name, :source_address, :source_phone, 
            :source_email, presence: true

  enum status: %i[pending whitelisted blacklisted]

  def self.search(search_term, approved, sort_field, page, user_id, export)
    current_user = User.find(user_id)

    results = Submission.all
    
    unless search_term.nil? || search_term.empty?
      if SubmissionPolicy.new(current_user, Submission).admin_index?
        results = results.where('company_name iLIKE :search_term OR
          seller_name iLIKE :search_term OR
          isbn iLIKE :search_term OR
          source_name iLIKE :search_term OR
          source_address iLIKE :search_term OR
          source_phone iLIKE :search_term OR
          source_email iLIKE :search_term OR
          notes iLIKE :search_term',
        { search_term: "%#{search_term}%" })

      else
        results = Submission.where(
          'company_name iLIKE :search_term OR seller_name iLIKE :search_term',
         { search_term: "%#{search_term}%" }).order(:company_name)
      end
    end

    sort_field = 'created_at' unless sort_field
    results = results.order(sort_field.to_s)
    
    unless approved.nil? || approved.empty?
      results = results.where('approved = :approved', { approved: approved })
    end
    
    results = results.page(page) unless export

    results
  end
end
