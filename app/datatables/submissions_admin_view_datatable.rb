class SubmissionsAdminViewDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      company_name: { source: "Submission.company_name" },
      seller_name: { source: "Submission.seller_name" },
      quantity: { source: "Submission.quantity" },
      isbn: { source: "Submission.isbn" },
      status: { source: "Submission.status" },
      counterfeits: { source: "Submission.counterfeits" },
      source_name: { source: "Submission.source_name" },
      source_address: { source: "Submission.source_address" },
      source_phone: { source: "Submission.source_phone" },
      source_email: { source: "Submission.source_email" },
      notes: { source: "Submission.notes" },
      approved: { source: "Submission.approved" }
    }
  end

  def data
    records.map do |record|
      record_map(record)
    end
  end

  def record_map(record)
    {
      company_name: record.company_name,
      seller_name: record.seller_name,
      quantity: record.quantity,
      isbn: record.isbn,
      status: record.status,
      counterfeits: record.counterfeits,
      source_name: record.source_name,
      source_address: record.source_address,
      source_phone: record.source_phone,
      source_email: record.source_email,
      notes: record.notes,
      approved: record.approved
    }
  end

  def get_raw_records(*)
    Submission.search(
      params[:search_term],
      params[:approved],
      params[:sort_field],
      params[:page],
      params[:user_id],
      false
    )
  end

end
