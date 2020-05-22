// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery");
require("bootstrap");
require("bootstrap-table");
require("bootstrap-daterangepicker");
require("moment");
require("bootstrap-daterangepicker");
require("@fortawesome/fontawesome-free");
require('datatables.net');
require('datatables.net-bs4');

require("../custom/sidebar")
require("../custom/amazon_table")
require("../custom/indaba_sku_tab")
require("../custom/book_table")
require("../custom/amazon_shipment_data_table")
require("../custom/combine_shipment_data_table")

import "@fortawesome/fontawesome-free/css/all.css";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

global.$ = jQuery;
