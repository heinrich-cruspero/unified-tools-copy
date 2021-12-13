# frozen_string_literal: true

##
class Submission < ApplicationRecord
  self.per_page = 10

  belongs_to :user

  validates :company_name, :seller_name, :quantity, :isbn,
            :source_name, presence: true

  enum status: %i[Pending Whitelisted Blacklisted]

  def self.admin_search(search_term, approved, sort_field, page, export)
    results = Submission.all

    unless search_term.nil? || search_term.empty?
      results = results.where('company_name iLIKE :search_term OR
                                  seller_name iLIKE :search_term OR
                                  isbn iLIKE :search_term OR
                                  source_name iLIKE :search_term OR
                                  source_address iLIKE :search_term OR
                                  source_phone iLIKE :search_term OR
                                  source_email iLIKE :search_term OR
                                  notes iLIKE :search_term',
                              { search_term: "%#{search_term}%" })
    end

    unless approved.nil? || approved.empty?
      results = results.where('approved = :approved', { approved: approved })
    end

    results = results.order(sort_field.to_s)

    results = results.page(page) unless export

    results
  end

  def self.user_search(search_term, page, export)
    results = Submission.all

    unless search_term.nil? || search_term.empty?
      results = Submission.where('company_name iLIKE :search_term OR
                                  seller_name iLIKE :search_term',
                                 { search_term: "%#{search_term}%" }).order(:company_name)
    end

    results = results.page(page) unless export

    results
  end

  def self.to_csv(current_user)
    attributes = if current_user.is_admin? || current_user.is_super_admin?
                   %w[company_name seller_name quantity isbn status counterfeits
                      source_name source_address source_phone source_email
                      notes approved]
                 else
                   %w[company_name seller_name status]
                 end

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |submission|
        csv << attributes.map { |attr| submission.send(attr) }
      end
    end
  end
end
