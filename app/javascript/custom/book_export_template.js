$( document ).on('turbolinks:load', function() {
    $("#field-mappings").sortable();

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

    $("#export_template_form").on('click', '.add_fields', function(event){
      let regexp, time;
      time = new Date().getTime();
      regexp = new RegExp($(this).data('id'), 'g');
      $(this).before($(this).data('fields').replace(regexp, time));
      return event.preventDefault();
    })

    $("#export_template_form").on('click', '.remove_fields', function(event){
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('.field').find('.field-select').attr('disabled', 'disabled');
      $(this).closest('.field').hide();
      return event.preventDefault();
    })
});