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
            {"data": "edition_status_code"},
            {"data": "edition_status_date"},
            {"data": "list_price"},
            {"data": "used_wholesale_price"},
            {"data": "nebraska_wh"},
            {"data": "qa_aug_low"},
            {"data": "lowest_good_price"},
            {"data": "qa_low"},
            {"data": "yearly_low"},
            {"data": "qa_fba_low"},
            {"data": "monthly_sqf"},
            {"data": "monthly_spf"},
            {"data": "monthly_rqf"},
            {"data": "monthly_rpf"},
            {"data": "one_year_highest_wholesale_price"},
            {"data": "two_years_wh_max"},
            {"data": "publisher"},
            {"data": "publication_date"},
            {"data": "weight"},
            {"data": "name"},
            {"data": "date"},
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
