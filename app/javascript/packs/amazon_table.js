;! function() {
    $container = $('#content');
    $container
      .on('change', '#inputGroupSelect01', onShowEntriesSelect)
      .on('click', '#amazon-table-search-submit', onClickSearchSubmit)
      .on('click', '#import-csv-submit', onImportCSVSubmit)

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

    function onShowEntriesSelect(event) {
      appendParamsToURL('show', $(this).val());
    };

    function onClickSearchSubmit(event) {
      appendParamsToURL('query', $('#amazon-table-search-form').val());
    };

    function onImportCSVSubmit(event) {
      $('#spinner').show();
    }

}();