const { environment } = require('@rails/webpacker');

var webpack = require('webpack');
const datatables = require('./loaders/datatables')
environment.loaders.append('datatables', datatables)
environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']

}));

module.exports = environment;
