$( document ).on('turbolinks:load', function() {
    $('#amazon-shipments-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "ajax": $('#amazon-shipments-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "isbn"},
            {"data": "shipment_id"},
            {"data": "az_sku"},
            {"data": "quantity_shipped"},
            {"data": "quantity_in_case"},
            {"data": "quantity_received"},
            {"data": "quantity_difference"},
            {"data": "condition"},
            {"data": "fulfillment_network_sku"},
            {"data": "reconciled"},
            {"data": "created_at"},
            {"data": "updated_at"},
        ]
    });

    $container = $('#content');
    $container
        .on('click', '#export-amazon-shipments-submit-button', onAmazonShipmentExportButtonClick)

    function onAmazonShipmentExportButtonClick(event) {
        event.preventDefault();
        onExportSubmit(this, $('#amazon-shipments-datatable').DataTable().ajax.params());
    }
});
