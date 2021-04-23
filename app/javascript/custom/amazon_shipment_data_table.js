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

    $('#export-amazon-shipments-submit-button').on('click', function (e) {
        e.preventDefault();
        const url = $(this).attr('href')
        const params = $.param($('#amazon-shipments-datatable').DataTable().ajax.params());
        const delimiter = url.includes('?') ? '&' : '?';
        $.get(url + delimiter + params);
        $('#blockModal').modal({
            backdrop: 'static',
            keyboard: false
        });
    });
});
