$( document ).on('turbolinks:load', function() {
    $('.field-select').selectize();
    if ($('#field-mappings').length) {
      $("#field-mappings").sortable({
        update: function(event, ui){
          $('#field-mappings').sortable("refresh");
          update_pos();
        },
      });
      update_pos();
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
      $("#field-mappings .nested-fields").last().find('.field-select').selectize();
      update_pos()
      return event.preventDefault();
    })

    $("#export_template_form").on('click', '.remove_fields', function(event){
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('.field').find('.field-select').attr('disabled', 'disabled');
      $(this).closest('.field').hide();
      $('#field-mappings').sortable("refresh");
      update_pos();
      return event.preventDefault();
    })
});

function update_pos(){
  $.map($("#field-mappings").find('.nested-fields .field-select:enabled'), function(el, index){
    $(el).closest('.nested-fields').find('input.field-position').val(index);
  })
}