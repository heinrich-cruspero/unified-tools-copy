$( document ).on('turbolinks:load', function() {
    $(".route-select-field").selectize();

    $(".add-routes").on('click', '.add_fields', function(event){
        let regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');

        let el = $($(this).data('fields').replace(regexp, time));
        let existing_fields = $('#feature-routes .nested-fields .field select.route-select-field:not(:disabled)').find(':selected');
        
        $('#feature-routes').append(el);
        let $select = $("#feature-routes .nested-fields").last().find('.route-select-field').selectize();
        $.each(existing_fields, function(key, obj) {
            let val = $(obj).val();
            let selectize = $select[0].selectize;
            selectize.removeOption(val);
        });
        return event.preventDefault();
    })
    
    $("#feature_form").on('click', '.remove_fields', function(event){

        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.field').find('.route-select-field').attr('disabled', 'disabled');
        $(this).closest('.field').find('div.route-select-field input').removeAttr('required');
        $(this).closest('.field').hide();

        let existing_fields = $('#feature-routes .nested-fields select.route-select-field');
        let removed_field = $(this).closest('.field').find('select.route-select-field');

        $.each(existing_fields, function(key, obj) {
            let selectize = $(obj)[0].selectize;
            selectize.addOption({
                text: $(removed_field).text(),
                value: $(removed_field).val()
            });
        });

        return event.preventDefault();
    })
});