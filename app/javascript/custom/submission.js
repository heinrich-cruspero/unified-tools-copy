$(document).on('turbolinks:load', function() {

    $('.export-submissions-button').on('click', function(e) {
        e.preventDefault();
        const baseUrl = $(this).attr('href');
        let url = new URL(window.location.href);
        const delimiter = baseUrl.includes('?') ? '&' : '?';
        $.get(baseUrl + delimiter + url.searchParams.toString());
        $('#blockModal').modal({
            backdrop: 'static',
            keyboard: false
        });
    });
});