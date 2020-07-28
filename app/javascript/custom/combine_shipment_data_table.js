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
        ]
    });

    $container = $('#content');
    $container
        .on('click', '#export-combined-shipments-submit-button', onExportButtonClick)

    function onExportButtonClick(event) {
        event.preventDefault();
        $("#export-combined-shipments-params").val(JSON.stringify($('#combine-shipments-datatable').DataTable().ajax.json().data));
        $("#export-combined-shipments-form").submit();
    }
});
