$( document ).on('turbolinks:load', function() {
    $('#amazon-order-items-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "ajax": $('#amazon-order-items-datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "amazon_order_id"},
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

    $('#export-order-items-button').on('click', function(e) {
        e.preventDefault();
        const url = $(this).attr('href');
        const params = $.param($('#amazon-order-items-datatable').DataTable().ajax.params());
        const delimiter = url.includes('?') ? '&' : '?';
        $.get(url + delimiter + params);
        $('#blockModal').modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    $('#amazon-order-item-purchase-date-filter').daterangepicker({
        "autoApply": true,
        "autoUpdateInput": false,
        "locale": {
            "format": "YYYY-MM-DD"
        },
    });

    $('#amazon-order-item-purchase-date-filter').on('apply.daterangepicker', function(ev, picker) {
        const startDate = picker.startDate.format('YYYY-MM-DD');
        const endDate = picker.endDate.format('YYYY-MM-DD');

        $(this).val(`${startDate} - ${endDate}`);
        let url = new URL(window.location.href);
        url.searchParams.set("filters[purchase_start_date]", startDate);
        url.searchParams.set("filters[purchase_end_date]", endDate);
        window.location.href = url.toString();
    });

    $('.select_sale_type_filter').on('change', function() {
        const sale_type = this.options[this.selectedIndex].value;
        let url = new URL(window.location.href);
        url.searchParams.set("filters[sale_type]", sale_type);
        window.location.href = url.toString();
    });
});

