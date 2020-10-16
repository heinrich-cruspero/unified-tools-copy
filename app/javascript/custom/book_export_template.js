$( document ).on('turbolinks:load', function() {
    $("#field-mappings").sortable();
    $("#link_add a").data("association-insertion-method", 'append').
      data("association-insertion-node", '#field-mappings');
});