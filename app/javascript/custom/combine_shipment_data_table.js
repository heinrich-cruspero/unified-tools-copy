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

    $('#export-combined-shipments-submit-button').on('click', function (e) {
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
