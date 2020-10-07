$( document ).on('turbolinks:load', function() {
    const search_book_field = document.getElementById("search_book")
    if (search_book_field) { 
        search_book_field.addEventListener("input", e => {
            e.preventDefault();
            searchBook();
        });
    }

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