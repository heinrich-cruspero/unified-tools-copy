$( document ).on('turbolinks:load', function() {
    // TODO: searchable route dynamic add

    $(".add-routes").on('click', '.add_fields', function(event){
        let regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('#feature-routes').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    })
    
    $("#feature_form").on('click', '.remove_fields', function(event){
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.field').find('.field-select').attr('disabled', 'disabled');
        $(this).closest('.field').hide();
        return event.preventDefault();
    })
});