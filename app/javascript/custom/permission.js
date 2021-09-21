$( document ).on('turbolinks:load', function() {
    if ($('#permission-field-mappings').length) {
        $("#permission-field-mappings").sortable({
          update: function(event, ui){
            $('#permission-field-mappings').sortable("refresh");
          },
        });
    }

    const $authorizable_radios = $('input:radio[name=authorizable_options]');
    if($authorizable_radios.is(':checked') === false) {
        $authorizable_radios.filter('[value=user]').prop('checked', true);
    }
    $(".authorizable-select.role").hide();

    $('input[name="authorizable_options"]').click(function(){
        const inputValue = $(this).attr("value");
        const targetBox = $("." + inputValue);
    
        $(".authorizable-select").not(targetBox).hide();
        $(targetBox).show();
    });

    $("#permission_form").on('click', '.add_fields', function(event){
        let regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('#permission-field-mappings').append($(this).data('fields').replace(regexp, time));
        $('#permission-field-mappings').sortable("refresh");
        return event.preventDefault();
    })
  
    $("#permission_form").on('click', '.remove_fields', function(event){
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('.field').find('.field-select').attr('disabled', 'disabled');
      $(this).closest('.field').hide();
      $('#permission-field-mappings').sortable("refresh");
      return event.preventDefault();
    })
});