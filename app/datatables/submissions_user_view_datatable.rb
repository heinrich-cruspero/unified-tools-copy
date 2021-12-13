class SubmissionsUserViewDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      company_name: { source: "Submission.company_name" },
      seller_name: { source: "Submission.seller_name" },
      status: { source: "Submission.status" },
      notes: { source: "Submission.notes" }
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
      status: record.status,
      notes: record.notes
    }
  end

  def get_raw_records(*)
    Submission.search(
      params[:search_term],
      params[:approved],
      params[:sort_field],
      params[:page],
      params[:user_id],
      false)
  end

end
