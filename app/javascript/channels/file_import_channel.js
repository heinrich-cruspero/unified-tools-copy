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
      $(".alert").remove();
      // for the upload_guide_import_job usage
      if (data.success == true) {
        $(".main-content").prepend(
          "<div class='alert alert-info'>Processed imported file.</div>"
        );
      } else if (data.success == false) {
        $(".main-content").prepend(
          "<div class='alert alert-warning'>Failed to process file. Please try again.</div>"
        );
      } else {
        // other jobs
        $(".main-content").prepend(
          "<div class='alert alert-info'>Processed imported file.</div>"
        );
      }
      
      consumer.disconnect()
    }
  });
}

$( document ).on('turbolinks:load', function() {
  $('#add-isbn-form').on('submit', file_import_channel);
  $('#guide-import-form').on('submit', file_import_channel);
});