import consumer from "./consumer"

function guide_import_channel(){
  consumer.subscriptions.create("GuideImportChannel", {
    connected() {
      console.log('Connected to GuideImportChannel')
    },

    disconnected() {
      console.log('Disconnected from GuideImportChannel')
    },

    received(data) {
      console.log('Received on GuideImportChannel')

      $("#blockModal").modal('hide');
      consumer.disconnect()
    }
  });
}

$( document ).on('turbolinks:load', function() {
  $('#guide-import-form').on('submit', guide_import_channel);
});