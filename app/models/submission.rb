# frozen_string_literal: true

##
class Submission < ApplicationRecord
  self.per_page = 10

  belongs_to :user

  validates :company_name, :seller_name, :quantity, :isbn,
            :source_name, presence: true

  enum status: %i[Pending Whitelisted Blacklisted]

  def self.search(search_term, approved, sort_field, page, user_id, export)
    current_user = User.find(user_id)

    results = SubmissionPolicy::Scope.new(
      current_user, Submission).resolve
    
    unless search_term.nil? || search_term.empty?
      if current_user.is_super_admin? || current_user.is_admin?
        results = results.where('company_name iLIKE :search_term OR
          seller_name iLIKE :search_term OR
          isbn iLIKE :search_term OR
          source_name iLIKE :search_term OR
          source_address iLIKE :search_term OR
          source_phone iLIKE :search_term OR
          source_email iLIKE :search_term OR
          notes iLIKE :search_term',
        { search_term: "%#{search_term}%" })

        sort_field = 'created_at' unless sort_field
        results = results.order(sort_field.to_s)
      else
        results = Submission.where('company_name iLIKE :search_term OR
          seller_name iLIKE :search_term',
         { search_term: "%#{search_term}%" }).order(:company_name)
      end
    end
    
    unless approved.nil? || approved.empty?
      results = results.where('approved = :approved', { approved: approved })
    end
    
    results = results.page(page) unless export

    results
  end
end
