$( document ).on('turbolinks:load', function() {
    $container = $('#content');
    $container.on('click', '#sku-table-date-search-submit', onClickDateSubmit)

    function appendParamsToURL(key, value) {
        key = encodeURI(key);
        value = encodeURI(value);
        var kvp = document.location.search.substr(1).split('&');
        if (kvp == '') {
            document.location.search = '?' + key + '=' + value;
        } else {
            var i = kvp.length;
            var x;
            while (i--) {
                x = kvp[i].split('=');

                if (x[0] == key) {
                    x[1] = value;
                    kvp[i] = x.join('=');
                    break;
                }
            }

            if (i < 0) {
                kvp[kvp.length] = [key, value].join('=');
            }
            document.location.search = kvp.join('&');
        }
    }

    function onClickDateSubmit(event) {
        appendParamsToURL('date', $('#sku-table-search-form').val());
    };

    function onImportCSVSubmit(event) {
        $('#spinner').show();
    }

    $(function () {
      $('input[name="daterange"]').daterangepicker({
        opens: 'left',
        locale: {
          format: 'YYYY-MM-DD'
        }
      }, function(start, end, label) {
        console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
      });
    });
});
