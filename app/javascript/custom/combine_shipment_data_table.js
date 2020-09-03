$( document ).on('turbolinks:load', function() {
    $('#combine-shipments-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "ajax": $('#combine-shipments-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "shipment_id"},
            {"data": "quantity_shipped"},
            {"data": "quantity_in_case"},
            {"data": "quantity_received"},
            {"data": "quantity_difference"},
            {"data": "created_at"},
        ]
    });

    $container = $('#content');
    $container
        .on('click', '#export-combined-shipments-submit-button', onCombinedShipmentExportButtonClick)

    function onCombinedShipmentExportButtonClick(event) {
        event.preventDefault();
        onExportSubmit(this, $('#combine-shipments-datatable').DataTable().ajax.params());
    }
});
