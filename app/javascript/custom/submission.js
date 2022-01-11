$(document).on('turbolinks:load', function() {
    let url = new URL(window.location.href);
    let statuses = url.searchParams.getAll('filters[status][]');

    $('.admin-status-select-field').selectize({
        maxItems: 3,
        items: statuses,
        valueField: 'status',
        labelField: 'status',
        onChange: function(values) {
            let url = new URL(window.location.href);
            url.searchParams.delete('filters[status][]');
            values.forEach(val => {
                url.searchParams.append('filters[status][]', val)
            });
            window.location.href = url.toString();
        }
    });

    // ADMIN
    let submissions_admin_datatable = $('#submissions_admin_datatable').DataTable({
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        "order": [[0, "desc"]],
        "columnDefs": [
            {"className": "dt-center", "targets": "_all"}
          ],
        "ajax": $('#submissions_admin_datatable').data('source'),
        "pagingType": "full_numbers",
        "columns": [
            {"data": "company_name"},
            {"data": "seller_name"},
            {"data": "quantity"},
            {"data": "isbn"},
            {"data": "status"},
            {"data": "counterfeits"},
            {"data": "source_name"},
            {"data": "source_address"},
            {"data": "source_phone"},
            {"data": "source_email"},
            {"data": "notes"},
            {"data": "approved"},
        ]
    });

    $('#submissions_admin_datatable').on('click', 'tbody tr', function () {
        var id = submissions_admin_datatable.row( this ).id();

        if (id != undefined) {
            window.location = '/submissions/'+id;
        }
    });

    // ADMIN
    $('#export-admin-submissions-button').on('click', function (e) {
        e.preventDefault();
        
        const url = $(this).attr('href')
        const params = $.param($('#submissions_admin_datatable').DataTable().ajax.params());
        const delimiter = url.includes('?') ? '&' : '?';
        
        $.get(url + delimiter + params);

        $('#blockModal').modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    $('#submissions-clear-filters').click(function() {
        let url = new URL(window.location.href);
        url.searchParams.delete('filters[approved]');
        url.searchParams.delete('filters[status][]');

        window.location.href = url.toString();
    });
});