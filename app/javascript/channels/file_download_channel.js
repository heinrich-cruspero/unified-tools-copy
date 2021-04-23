import consumer from "./consumer"

function file_download_channel(){
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
}

$( document ).on('turbolinks:load', function() {
  $('#export-order-items-button').on('click', file_download_channel);
  $('#export-use-form').on('submit', file_download_channel);
  $('#export-amazon-shipments-submit-button').on('click', file_download_channel);
});
