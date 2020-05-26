$( document ).on('turbolinks:load', function() {
    $('#combine-shipments-datatable').dataTable({
        "processing": true,
        "serverSide": false,
        "scrollX": true,
        "columnDefs": [{ "orderable": false, "targets": -1 }],
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
});
