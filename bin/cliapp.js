#! /usr/bin/env node

var App = require('../src').App;

var app = new App();
app.on('error', function (message) {
    console.log(message);
    process.exit(1);
});
app.run();
