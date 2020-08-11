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
        const url = $(this).attr('href');
        const delimiter = url.includes('?') ? '&' : '?';
        const params = $.param($('#combine-shipments-datatable').DataTable().ajax.params());
        window.location.href = url + delimiter + params;
    }
});
