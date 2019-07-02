let createError = require('http-errors');

class Utils {
    // Enable CORS
    static enableCORS(app) {
        app.use(function (req, res, next) {
            res.header("Access-Control-Allow-Origin", "*");
            res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
            next();
        });
    }

    // catch 404 and forward to error handler
    static error404Catch(app) {
        app.use(function (req, res, next) {
            next(createError(404));
        });
    }

    // error handler
    static handleErrors(app, callback) {
        app.use(function (err, req, res, next) {
            err.status = err.status || 500;
            callback(err, res);
        });
    }


}

module.exports = Utils;