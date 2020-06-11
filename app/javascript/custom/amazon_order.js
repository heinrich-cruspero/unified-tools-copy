$( document ).on('turbolinks:load', function() {
    $('#amazon-orders-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "autoWidth": false,
        "scrollX": true,
        "columnDefs": [{"targets": -1}],
        "ajax": $('#amazon-orders-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "order_total"},
            {"data": "purchase_date"},
            {"data": "status"},
            {"data": "amazon_order_id"},
            {"data": "state"},
            {"data": "city"},
            {"data": "zipcode"},
            {"data": "amazon_order_item"}
        ]
    });
});
