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
            {"data": "author"},
            {"data": "title"},
            {"data": "edition"},
            {"data": "publisher"},
            {"data": "publication_date"},
            {"data": "weight"},
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
            {"data": "created_at"},
            {"data": "updated_at"},
            {"data": "reconciled"}
        ]
    });

    $container = $('#content');
    $container
        .on('click', '#export-amazon-shipments-submit-button', onExportButtonClick)

    function onExportButtonClick(event) {
        event.preventDefault();
        $("#export-amazon-shipments-params").val(JSON.stringify($('#amazon-shipments-datatable').DataTable().ajax.json().data));
        $("#export-amazon-shipments-form").submit();
    }
});