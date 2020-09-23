import consumer from "./consumer"

$( document ).on('turbolinks:load', function() {
  $('#export-order-items-button').on('click', function(e) {

    consumer.subscriptions.create("FileDownloadChannel", {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log('Connected to FileDownloadChannel')
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
        console.log('Disconnected from FileDownloadChannel')
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log('Received on FileDownloadChannel')

        window.location.href = data.download_url;
        $("#blockModal").modal('hide');
        consumer.disconnect()
      }
    });
  });
});
