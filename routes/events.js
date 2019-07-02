let express = require('express');
let router = express.Router();
let database = require('../database/database');

/* GET home page. */
router.get('/', async function (req, res, next) {
    return res.send(await database.getAllEvents());
});

module.exports = router;