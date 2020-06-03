$( document ).on('turbolinks:load', function() {
    $('#books-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "columnDefs": [{ "orderable": false, "targets": -1 }],
        "ajax": $('#books-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "ean"},
            {"data": "isbn"},
            {"data": "author"},
            {"data": "title"},
            {"data": "edition"},
            {"data": "subject"},
            {"data": "publication_date"},
            {"data": "copyright"},
            {"data": "publisher"},
            {"data": "edition_status_code"},
            {"data": "edition_status_date"},
            {"data": "grade"},
            {"data": "list_price"},
            {"data": "used_wholesale_price"},
            {"data": "max_wholesale_price"},
            {"data": "trade_in"},
            {"data": "lowest_price"},
            {"data": "sales_rank"},
            {"data": "sales_rank_aug_avg"},
            {"data": "amazon_rental"},
            {"data": "lowest_rental"},
            {"data": "fcb_price"},
            {"data": "fba_price"},
            {"data": "updated_at"}
        ]
    });
});
