$( document ).on('turbolinks:load', function() {
    $("#search_book").on("keyup", function(){
        searchBook();
    });

    let search_val = $('#search_book').val()
    $.ajax({
        type: "GET",
        url: "/books/" + search_val + "/detail_guides",
        dataType: "script"
    })

    function searchBook(){
        let book_val = $('#search_book').val()
        if (book_val.length == 10 || book_val.length == 13) {
            window.location.pathname = "/books/" + book_val + "/details"
        }
    }
});