// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery");
require("jquery-ui-dist/jquery-ui");
require("bootstrap");
require("bootstrap-table");
require("bootstrap-daterangepicker");
require("moment");
require("@fortawesome/fontawesome-free");
require("datatables.net");
require("datatables.net-bs4");
require("chartkick");
require("chart.js");
require("selectize");

require("../custom/sidebar")
require("../custom/amazon_table")
require("../custom/indaba_sku_tab")
require("../custom/book")
require("../custom/book_details")
require("../custom/book_export_template")
require("../custom/amazon_order")
require("../custom/amazon_order_item")
require("../custom/amazon_associated_items")
require("../custom/amazon_shipment_data_table")
require("../custom/combine_shipment_data_table")
require("../custom/indaba_sku_data_table")
require("../custom/permission")
require("../custom/user")
require("../custom/feature")
require("../custom/guide_import")
require("../custom/submission")


import "@fortawesome/fontawesome-free/css/all.css";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

global.$ = jQuery;
