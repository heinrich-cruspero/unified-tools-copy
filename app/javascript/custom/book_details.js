$( document ).on('turbolinks:load', function() {
    $("#search_book").on("keyup", function(){
        searchBook();
    });

    var book_obj = document.getElementById("book-record")
    if (!book_obj){
        $("#book-details-main").removeClass("book-details-table");
        $("#book-details-main").attr("id", "");
        $("#book-details-amazon-inventory").removeClass("book-details-table");
        $("#book-details-amazon-inventory").attr("id", "");
    }


    function searchBook(){
        var book_val = $('#search_book').val()
        if (book_val.length == 10 || book_val.length == 13) {
            window.location.pathname = "/books/" + book_val + "/details"
        }
    }
});