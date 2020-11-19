$( document ).on('turbolinks:load', function() {
    if ($('#field-mappings').length) {
      $("#field-mappings").sortable({
        update: function(event, ui){
          $('#field-mappings').sortable("refresh");
          $.map($(this).find('.ui-sortable-handle'), function(el){
            $(el).find('input.field-position').val($(el).index());
          })
        },
      });

      
    }

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
      $('#field-mappings').append($(this).data('fields').replace(regexp, time));
      $('#field-mappings').sortable("refresh");
      $.map($('#field-mappings').find('.ui-sortable-handle'), function(el){
        $(el).find('input.field-position').val($(el).index());
      })
      return event.preventDefault();
    })

    $("#export_template_form").on('click', '.remove_fields', function(event){
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('.field').find('.field-select').attr('disabled', 'disabled');
      $(this).closest('.field').hide();
      $(this).closest('.ui-sortable-handle').appendTo('#removed');
      $('#field-mappings').sortable("refresh");
      $.map($('#field-mappings').find('.ui-sortable-handle'), function(el){
        $(el).find('input.field-position').val($(el).index());
      })
      return event.preventDefault();
    })
});