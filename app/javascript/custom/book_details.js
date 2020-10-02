$( document ).on('turbolinks:load', function() {
    const search_book_field = document.getElementById("search_book")
    if (search_book_field) { 
        search_book_field.addEventListener("input", e => {
            e.preventDefault();
            searchBook();
        });
    }

    function searchBook(){
        var field_len = $('#search_book').val().length;
        if (field_len == 10 || field_len == 13) {
            $.ajax({
                url : "/books/details",
                data : $(".book-form").serialize()
            });
        }
    }
});