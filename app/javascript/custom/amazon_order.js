$( document ).on('turbolinks:load', function() {
    $('#amazon-orders-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "ajax": $('#amazon-orders-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "amazon_order_id"},
            {"data": "status"},
            {"data": "state"},
            {"data": "city"},
            {"data": "zipcode"},
            {"data": "order_total"},
            {"data": "purchase_date"},
            {"data": "amazon_order_item"}
        ]
    });
});
