$( document ).on('turbolinks:load', function() {
    $("#field-mappings").sortable();
    $("#link_add a").data("association-insertion-method", 'append').
      data("association-insertion-node", '#field-mappings');

    $('#export-use-form').on('submit', function(e) {
      e.preventDefault();
      const export_url = $(this).attr('action');
      let form_data = new FormData(this);

      $.ajax({
        url: export_url,
        data: form_data,
        cache: false,
        processData: false,
        contentType: false,
        type: 'POST'
      })
      $('#blockModal').modal({
          backdrop: 'static',
          keyboard: false
      });
    });
});