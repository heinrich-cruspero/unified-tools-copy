class AmazonShipmentsController < ApplicationController
  include AmazonShipmentCsvModule

  before_action :authenticate_user!

  def index
    @amazon_shipment_items = AmazonShipment.paginate(page: params[:page], per_page: 25)
  end

  def import
    if request.post?
      uploaded_file = params[:csv_file]

      if uploaded_file
        self.process_csv uploaded_file
        redirect_to amazon_shipments_url, notice: 'Successfully imported file.'
      else
        redirect_to import_amazon_shipments_url, notice: 'Missing csv file.'
      end
    end
  end

end
