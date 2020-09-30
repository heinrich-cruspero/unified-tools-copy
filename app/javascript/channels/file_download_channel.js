import consumer from "./consumer"

$( document ).on('turbolinks:load', function() {
  $('#export-order-items-button').on('click', function(e) {

    consumer.subscriptions.create("FileDownloadChannel", {
      connected() {
        console.log('Connected to FileDownloadChannel')
      },

      disconnected() {
        console.log('Disconnected from FileDownloadChannel')
      },

      received(data) {
        console.log('Received on FileDownloadChannel')

        window.location.href = data.download_url;
        $("#blockModal").modal('hide');
        consumer.disconnect()
      }
    });
  });
});
