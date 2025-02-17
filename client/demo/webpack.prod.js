const path = require("path");
const { merge } = require('webpack-merge');
const common = require('./webpack.common.js')

module.exports = merge(common, {
    mode: 'production',
    output: {
        publicPath: '/voice_changer/',
        filename: "index.js",
        path: path.resolve(__dirname, "dist"),
    },
})
