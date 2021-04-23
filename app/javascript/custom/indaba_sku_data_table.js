$( document ).on('turbolinks:load', function() {
    $dataTable = $('#indaba-sku-datatable').dataTable({
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
            {
                "data": "title",
                "render": function (data, type, full, meta) {
                    let truncated = data.length > 30 ? data.substr( 0, 30 ) +'…' : data;
                    return '<span data-toggle="tooltip" style="cursor: pointer;" title="' + data + '">' + truncated + '</span>';
                }
            },
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
        ],
    });

    $dataTable.on('draw.dt', function () {
        $('[data-toggle="tooltip"]').tooltip();
    });

    $('#export-indaba-sku-submit-button').on('click', function (e) {
        e.preventDefault();
        const url = $(this).attr('href')
        const params = $.param($('#indaba-sku-datatable').DataTable().ajax.params());
        const delimiter = url.includes('?') ? '&' : '?';
        $.get(url + delimiter + params);
        $('#blockModal').modal({
            backdrop: 'static',
            keyboard: false
        });
    });
});
