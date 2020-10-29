$( document ).on('turbolinks:load', function() {
    $("#search_book").on("keyup", function(){
        searchBook();
    });

    let search_val = $('#search_book').val()
    $.ajax({
        type: "GET",
        url: "/books/" + search_val + "/detail_guides",
        dataType: "json",
        complete: function(result){
            $("#guides-div").html(result.responseJSON.html);
        }
    })

    $.ajax({
        type: "GET",
        url: "/books/" + search_val + "/quantity_history",
        dataType: "json",
        complete: function(result){
            $("#quantity-history-div").html(result.responseJSON.quantity_history);
        }
    })
    
    $("#quantityHistoryModal").on('show.bs.modal', function() {
        opener = document.activeElement;
        qh_col = $(opener).closest(".col-data").find("input[name='qh-col-data']").val()
        qh_date = $(opener).closest(".qh-detail-row").find(".qh-date").text().replace(/\s/g, "");

        $("#modal-chart").html("");
        $("#chart-spinner").show();
        $.ajax({
            type: "GET",
            data: {date: qh_date, column_name: qh_col},
            url: "/books/" + search_val + "/quantity_history_chart",
            dataType: "json",
            complete: function(result){
                $("#chart-spinner").hide();
                $("#modal-chart").html(result.responseJSON.qh_chart_data);
            }
        })
    })

    function searchBook(){
        let book_val = $('#search_book').val()
        if (book_val.length == 10 || book_val.length == 13) {
            window.location.pathname = "/books/" + book_val + "/details"
        }
    }
});