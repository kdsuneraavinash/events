let express = require('express');
let utils = require('./utils');
let path = require('path');
let eventsRouter = require('./routes/events');
let eventRouter = require('./routes/event');

let app = express();

var server_port = process.env.OPENSHIFT_NODEJS_PORT || 8080
var server_ip_address = process.env.OPENSHIFT_NODEJS_IP || '127.0.0.1'

utils.enableCORS(app);

app.use('/api/events', eventsRouter);
app.use('/api/event', eventRouter);

// app.use(express.static(path.join(__dirname, 'dist', 'angular-events')));
app.use(express.static(path.join(__dirname, 'angular')));
app.get('/*', (req, res) => {
  res.sendFile(__dirname);
});

utils.error404Catch(app);
utils.handleErrors(app, (err, res) => {
  if (err.status === 404) {
    res.redirect('/');
  } else {
    res.status(err.status);
    res.send({
      'status': 'error',
      'code': err.status,
      'message': err.message
    });
  }
})

app.listen(server_port, server_ip_address, function () {
  console.log("Listening on " + server_ip_address + ", port " + server_port)
});
module.exports = app;