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

    $.ajax({
        type: "GET",
        url: "/books/" + search_val + "/rental_history",
        dataType: "json",
        complete: function(result){
            $("#rental-history-div").html(result.responseJSON.rental_history);
        }
    })
    $.ajax({
        type: "GET",
        url: "/books/" + search_val + "/fba_history",
        dataType: "json",
        complete: function(result){
            $("#fba-history-div").html(result.responseJSON.fba_history);
        }
    })
    $.ajax({
        type: "GET",
        url: "/books/" + search_val + "/lowest_history",
        dataType: "json",
        complete: function(result){
            $("#lowest-history-div").html(result.responseJSON.lowest_history);
        }
    })
    
    $("#historyModal").on('show.bs.modal', function() {
        opener = document.activeElement;
        hist_table = $(opener).closest(".qh-detail-row").find("input[name='hist-table']").val()
        hist_col = $(opener).closest(".col-data").find("input[name='qh-col-data']").val()
        hist_date = $(opener).closest(".qh-detail-row").find(".qh-date").text().replace(/\s/g, "");

        $.ajax({
            type: "GET",
            data: {
                table: hist_table,
                date: hist_date,
                column_name: hist_col
            },
            url: "/books/" + search_val + "/history_chart",
            dataType: "json",
            complete: function(d){
                var col_name = d.responseJSON.title
                $("#hist-datatable").dataTable({
                    data: d.responseJSON.data,
                    columns: [
                        {title: col_name, data: 'value'},
                        {title: 'Day', data: 'day'}
                    ],
                    order: [['1', 'desc']]
                });
            }
        })

        $("#modal-chart").html("");
        $("#modal-hist-datatable").hide();
        $("#chart-spinner").show();
        $.ajax({
            type: "GET",
            data: {
                table: hist_table,
                date: hist_date,
                column_name: hist_col},
            url: "/books/" + search_val + "/history_chart",
            dataType: "js",
            complete: function(result){
                $("#chart-spinner").hide();
                $("#modal-chart").html($.parseJSON(result.responseText).qh_chart_data);
                $("#modal-hist-datatable").show();
            }
        })
    })

    $('#historyModal').on('hidden.bs.modal', function () {
        $("#hist-datatable").dataTable().fnDestroy();
    })
      
    function searchBook(){
        let book_val = $('#search_book').val()
        if (book_val.length == 10 || book_val.length == 13) {
            window.location.pathname = "/books/" + book_val + "/details"
        }
    }
});