$( document ).on('turbolinks:load', function() {

    $(".add-book-field-mappings").on('click', '.add_fields', function(event){
        let regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('#permission-field-mappings').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    })

    $(".add-route-actions").on('click', '.add_fields', function(event){
        let regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('#permission-route-actions').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    })
  
    $("#permission_form").on('click', '.remove_fields', function(event){
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('.field').find('.field-select').attr('disabled', 'disabled');
      $(this).closest('.field').hide();
      return event.preventDefault();
    })
});