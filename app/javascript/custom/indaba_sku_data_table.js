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
        $("#export-indaba-sku-params").val(JSON.stringify($('#indaba-sku-datatable').DataTable().ajax.json().data));
        $("#export-indaba-sku-form").submit();
    }
});
