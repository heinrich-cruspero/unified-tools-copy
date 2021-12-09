$( document ).on('turbolinks:load', function() {
    $(".select-field").selectize();

    // AUTHORIZABLE: check the selected checkbox and hide/show div and attributes on load (new/edit)
    const authorizable_type = $(".authorizable_type").attr("value");
    if (authorizable_type === "") {
        $(".authorizable-select").not(".user").hide().find(".select-field").attr("disabled", true);
        $('input:radio[value=user]').prop('checked', true);
    } else {
        $(".authorizable-select").not("." + authorizable_type).hide().find(".select-field").attr("disabled", true);
        $('input:radio[value='+ authorizable_type +']').prop('checked', true);
    }

    // PERMISSIBLE: check the selected checkbox and hide/show div and attributes on load (new/edit)
    const permissible_type = $(".permissible_type").attr("value");
    if (permissible_type === "") {
        $(".permissible-select").not(".feature").hide().find(".select-field").attr("disabled", true);
        $('input:radio[value=feature]').prop('checked', true);
    } else {
        $(".permissible-select").not("." + permissible_type).hide().find(".select-field").attr("disabled", true);
        $('input:radio[value=' + permissible_type +']').prop('checked', true);
    }

    // AUTHORIZABLE: hide/show div on radio button switch
    $('input[name="authorizable_options"]').click(function(){
        const inputValue = $(this).attr("value");
        const targetBox = $("." + inputValue);
        
        // Set/unset selected field attributes for form submission
        $(".authorizable-select").not(targetBox).hide().find(".select-field").attr("disabled", true);
        $(targetBox).show().find(".select-field").attr("disabled", false);
    });

    // PERMISSIBLE hide/show div on radio button switch
    $('input[name="permissible_options"]').click(function(){
        const inputValue = $(this).attr("value");
        const targetBox = $("." + inputValue);
    
        // Set/unset selected field attributes for form submission
        $(".permissible-select").not(targetBox).hide();
        $(targetBox).show().find(".select-field").attr("disabled", false);

        $(".permissible-select").not(targetBox).each(function() {
            $(this).find(".select-field").attr("disabled", true);
        });
    });
});