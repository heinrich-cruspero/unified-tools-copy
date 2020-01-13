$( document ).on('turbolinks:load', function() {
  $container = $('#content');
  $container.on('click', '#sidebarCollapse', onToggleButtonClicked)

  function onToggleButtonClicked (event) {
    $('#sidebar').toggleClass('active');
    $('#content').toggleClass('active');
  };
});