const path = require("path");
const { merge } = require('webpack-merge');
const common = require('./webpack.common.js')

module.exports = merge(common, {
    mode: 'development',
    devServer: {
        static: {
            directory: path.join(__dirname, "public"),
        },
        proxy: [
            {
                context: ['/ws'],
                target: 'ws://192.168.1.33:18888/ws',
                ws: true,
                changeOrigin: true
            },
            {
                context: ['/'],
                // target: 'http://192.168.88.18:18888',
                target: 'http://44.244.56.154:18888',
                changeOrigin: true
            }
        ],
        client: {
            overlay: {
                errors: false,
                warnings: false,
            },
        },
        host: "0.0.0.0",
        port: 8090,
        // https: true,
    },
})
