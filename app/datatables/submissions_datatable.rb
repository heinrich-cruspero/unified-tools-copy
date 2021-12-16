class SubmissionsDatatable < AjaxDatatablesRails::ActiveRecord

    def view_columns
      @view_columns ||= {
        company_name: { source: "Submission.company_name", searchable: true },
        seller_name: { source: "Submission.seller_name", searchable: true },
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
      current_user = User.find(params[:user_id])
  
      SubmissionPolicy::Scope.new(
        current_user, 
        Submission
      ).resolve
    end
  
  end
  