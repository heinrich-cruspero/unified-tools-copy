;! function() {
  $container = $('#content');
  $container.on('click', '#sidebarCollapse', onSaveButtonClicked)

  function onSaveButtonClicked (event) {
    $('#sidebar').toggleClass('active');
    $('#content').toggleClass('active');
  };
}();