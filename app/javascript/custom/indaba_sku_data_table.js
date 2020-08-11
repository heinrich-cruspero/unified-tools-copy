$( document ).on('turbolinks:load', function() {
    $('#indaba-sku-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "ajax": $('#indaba-sku-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
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

    $container = $('#content');
    $container
        .on('click', '#export-indaba-sku-submit-button', onExportButtonClick)

    function onExportButtonClick(event) {
        event.preventDefault();
        const url = $(this).attr('href');
        const delimiter = url.includes('?') ? '&' : '?';
        const params = $.param($('#indaba-sku-datatable').DataTable().ajax.params());
        window.location.href = url + delimiter + params;
    }
});
