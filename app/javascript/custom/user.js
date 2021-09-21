$( document ).on('turbolinks:load', function() {
    const check_boxes = $('input:checkbox.user-role-checkbox');
    check_boxes.click(function() {
        check_boxes.prop('checked', false);
        $(this).prop('checked', true);
    });
});