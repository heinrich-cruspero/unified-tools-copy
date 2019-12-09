class AmazonShipmentsController < ApplicationController
  include AmazonShipmentCsvModule

  before_action :authenticate_user!

  def index
    params[:show].nil? ? per_page = 25 : per_page = params[:show]

    if params[:filter] == 'pending'
      amazon_shipment_items = AmazonShipment.pending
    elsif params[:filter] == 'twenty_days_pending'
      amazon_shipment_items = AmazonShipment.twenty_days_pending
    elsif params[:filter] == 'twenty_days_pending'
      amazon_shipment_items = AmazonShipment.twenty_days_pending
    elsif params[:filter] == 'combine_shipments'
      amazon_shipment_items = AmazonShipment.combine_shipments
    else
      amazon_shipment_items = AmazonShipment.all
    end

    # if not params[:show].nil?
    #   amazon_shipment_items

    @amazon_shipment_items = amazon_shipment_items.paginate(page: params[:page], per_page: per_page)
  end

  def import
    if request.post?
      uploaded_file = params[:csv_file]

      if uploaded_file
        self.process_csv uploaded_file
        redirect_to amazon_shipments_url, flash: { success: 'Successfully imported file.'}
      else
        redirect_to import_amazon_shipments_url, flash: { error: 'Missing csv file.' }
      end
    end
  end

end
