$( document ).on('turbolinks:load', function() {
    $('#guide-import-form').on('submit', function(e) {
        e.preventDefault();
        const guide_import_url = $(this).attr('action');
        let form_data = new FormData(this);

        $.ajax({
            url: guide_import_url,
            data: form_data,
            cache: false,
            processData: false,
            contentType: false,
            type: 'POST'
        });

        $('#blockModal').modal({
            backdrop: 'static',
            keyboard: false
        });
    });
});
