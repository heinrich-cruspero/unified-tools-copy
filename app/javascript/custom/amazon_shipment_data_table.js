$(document).ready(function() {
    $('#amazon-shipments-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "columnDefs": [{ "orderable": false, "targets": -1 }],
        "ajax": $('#amazon-shipments-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "isbn"},
            {"data": "shipment_id"},
            {"data": "condition"},
            {"data": "az_sku"},
            {"data": "fulfillment_network_sku"},
            {"data": "quantity_shipped"},
            {"data": "quantity_in_case"},
            {"data": "quantity_received"},
            {"data": "reconciled"},
            {"data": "edition_status_code"},
            {"data": "edition_status_date"},
            {"data": "list_price"},
            {"data": "used_wholesale_price"},
            {"data": "nebraska_wh"},
            {"data": "one_year_highest_wholesale_price"},
            {"data": "two_years_wh_max"},
            {"data": "qa_low"},
            {"data": "qa_aug_low"},
            {"data": "qa_fba_low"},
            {"data": "lowest_good_price"},
            {"data": "yearly_low"},
            {"data": "monthly_sqf"},
            {"data": "monthly_spf"},
            {"data": "monthly_rqf"},
            {"data": "monthly_rpf"},
            {"data": "created_at"},
            {"data": "updated_at"}
        ]
    });
});
