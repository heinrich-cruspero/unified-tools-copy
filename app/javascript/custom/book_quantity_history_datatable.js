$( document ).on('turbolinks:load', function() {
    $('#book-quantity-history-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "ajax": $('#book-quantity-history-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "price"},
            {"data": "day"},
        ]
    });
});
