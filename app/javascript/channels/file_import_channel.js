import consumer from "./consumer"

function file_import_channel(){
  consumer.subscriptions.create("FileImportChannel", {
    connected() {
      console.log('Connected to FileImportChannel')
    },

    disconnected() {
      console.log('Disconnected from FileImportChannel')
    },

    received(data) {
      console.log('Received on FileImportChannel')

      $("#blockModal").modal('hide');
      window.location = data.redirect_url
      
      consumer.disconnect()
    }
  });
}

$( document ).on('turbolinks:load', function() {
  $('#add-isbn-form').on('submit', file_import_channel);
});