$( document ).on('turbolinks:load', function() {
    $(".route-select-field").selectize();

    $(".add-routes").on('click', '.add_fields', function(event){
        let regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('#feature-routes').append($(this).data('fields').replace(regexp, time));
        $("#feature-routes .nested-fields").last().find('.route-select-field').selectize();
        return event.preventDefault();
    })
    
    $("#feature_form").on('click', '.remove_fields', function(event){
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.field').find('.route-select-field').attr('disabled', 'disabled');
        $(this).closest('.field').hide();
        return event.preventDefault();
    })
});