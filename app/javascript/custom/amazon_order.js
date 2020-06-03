$( document ).on('turbolinks:load', function() {
    $('#amazon-orders-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "columnDefs": [{ "orderable": false, "targets": -1 }],
        "ajax": $('#amazon-orders-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "order_total"},
            {"data": "purchase_date"},
            {"data": "status"},
            {"data": "amazon_order_id"},
            {"data": "amazon_order_item"}
        ]
    });
});
