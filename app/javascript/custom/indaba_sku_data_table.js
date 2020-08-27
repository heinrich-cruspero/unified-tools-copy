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
            {"data": "author"},
            {"data": "title"},
            {"data": "edition"},
            {"data": "status_code"},
            {"data": "stat_date"},
            {"data": "list"},
            {"data": "MBS_WH"},
            {"data": "NBC_WH"},
            {"data": "QaPC3"},
            {"data": "ALow"},
            {"data": "QaLow"},
            {"data": "YLow"},
            {"data": "QaFBALow"},
            {"data": "30SQF"},
            {"data": "30SPF"},
            {"data": "30RQF"},
            {"data": "30RPF"},
            {"data": "1YRWH"},
            {"data": "2YRWH"},
            {"data": "publisher"},
            {"data": "pub_date"},
            {"data": "weight"},
            {"data": "file_name"},
            {"data": "import_date"},
        ]
    });

    $container = $('#content');
    $container
        .on('click', '#export-indaba-sku-submit-button', onIndabaSKUExportButtonClick)

    function onIndabaSKUExportButtonClick(event) {
        event.preventDefault();
        onExportSubmit(this, $('#indaba-sku-datatable').DataTable().ajax.params());
    }
});
