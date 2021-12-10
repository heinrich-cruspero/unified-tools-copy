$( document ).on('turbolinks:load', function() {
    
    // Fixes bug not properly loading selectized fields 
    // when user clicks back/forward in the browser
    $(window).on('popstate', function() {
        location.reload(true);
    });
    
    const check_boxes = $('input:checkbox.user-role-checkbox');
    check_boxes.click(function() {
        check_boxes.prop('checked', false);
        $(this).prop('checked', true);
    });
});