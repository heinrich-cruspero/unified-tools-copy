$( document ).on('turbolinks:load', function() {
    $('#amazon-associated-items-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "ajax": $('#amazon-associated-items-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "order_item_id"},
            {"data": "asin"},
            {"data": "seller_sku"},
            {"data": "rni"},
            {"data": "sale_type"},
            {"data": "quantity_ordered"},
            {"data": "item_price"},
            {"data": "returned"},
            {"data": "buy_out"},
            {"data": "buy_out_price"},
            {"data": "expired"},
            {"data": "due_date"},
            {"data": "action_date"}
        ]
    });
});
