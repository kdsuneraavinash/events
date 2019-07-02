let express = require('express');
let utils = require('./utils');
let path = require('path');
let eventsRouter = require('./routes/events');
let eventRouter = require('./routes/event');

let app = express();

var port = process.env.PORT || 3000

utils.enableCORS(app);

app.use('/api/events', eventsRouter);
app.use('/api/event', eventRouter);

app.use(express.static(path.join(__dirname, 'angular', 'dist', 'angular-events')));
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

app.listen(port, () =>
  console.log("Listening on port " + port)
);

module.exports = app;