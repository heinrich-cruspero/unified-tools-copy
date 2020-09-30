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

    $('#export-order-items-button').on('click', function(e) {
        e.preventDefault();
        const url = $(this).attr('href');
        const params = $.param($('#amazon-orders-datatable').DataTable().ajax.params());
        const delimiter = url.includes('?') ? '&' : '?';
        $.get(url + delimiter + params);
        $('#blockModal').modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    $('#amazon-order-purchase-date-filter').daterangepicker({
        "autoApply": true,
        "autoUpdateInput": false,
        "locale": {
            "format": "YYYY-MM-DD"
        },
    });

    $('#amazon-order-purchase-date-filter').on('apply.daterangepicker', function(ev, picker) {
        const startDate = picker.startDate.format('YYYY-MM-DD');
        const endDate = picker.endDate.format('YYYY-MM-DD');

        $(this).val(`${startDate} - ${endDate}`);

        let url = new URL(window.location.href);
        url.searchParams.set("filters[purchase_start_date]", startDate);
        url.searchParams.set("filters[purchase_end_date]", endDate);
        window.location.href = url.toString();
    });
});
