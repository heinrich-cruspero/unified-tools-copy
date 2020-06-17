$( document ).on('turbolinks:load', function() {
    $('#amazon-associated-items-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "ajax": $('#amazon-associated-items-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "asin"},
            {"data": "sale_type"},
            {"data": "quantity_ordered"},
            {"data": "item_price"},
            {"data": "returned"},
            {"data": "buy_out"},
            {"data": "rni"},
            {"data": "action_date"},
            {"data": "due_date"},
            {"data": "expired"},
            {"data": "seller_sku"},
            {"data": "buy_out_price"}
        ]
    });
});
