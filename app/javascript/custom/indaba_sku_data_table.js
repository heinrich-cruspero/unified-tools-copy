$( document ).on('turbolinks:load', function() {
    $('#indaba-sku-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "columnDefs": [{ "orderable": false, "targets": -1 }],
        "ajax": $('#indaba-sku-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            // {"data": "shipment_id"},
            // {"data": "quantity_shipped"},
            // {"data": "quantity_in_case"},
            // {"data": "quantity_received"},
            // {"data": "quantity_difference"},
            {"data": "az_sku"},
            {"data": "isbn"},
            {"data": "shipment_id"},
            {"data": "sku"},
            {"data": "quantity"},
            {"data": "condition"},
            {"data": "name"},
            {"data": "date"},
        ]
    });
});
