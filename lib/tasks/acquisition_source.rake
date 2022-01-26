# frozen_string_literal: true

namespace :acquisition_source do
  desc 'Import Submissions from Acquisition Source repo db'

  task submissions: :environment do
    desc 'Usage: rails acquisition_source:submissions'

    connection = PG.connect(
      host: Rails.application.credentials[Rails.env.to_sym][:acquisition_source_db][:host],
      dbname: Rails.application.credentials[Rails.env.to_sym][:acquisition_source_db][:database],
      port: Rails.application.credentials[Rails.env.to_sym][:acquisition_source_db][:port],
      user: Rails.application.credentials[Rails.env.to_sym][:acquisition_source_db][:username],
      password: Rails.application.credentials[Rails.env.to_sym][:acquisition_source_db][:password]
    )

    submissions = connection.exec("
        SELECT s.company_name, s.seller_name, s.quantity, s.isbn,
               s.counterfeits, s.source_name, s.source_address,
               s.source_phone, s.source_email,
               s.notes, s.approved, s.status, s.created_at, s.updated_at,
               u.email
        FROM submissions s
        INNER JOIN users u ON u.id = s.user_id
      ")

    submissions.each do |submission|
      user = User.find_by(email: submission['email'])

      user = User.create!(email: submission['email']) if user.nil?
      submission.store('user_id', user.id)
      Submission.create!(submission.except('email'))
    end

    puts 'Created Submissions'
  end
end
