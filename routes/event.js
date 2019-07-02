let express = require('express');
let router = express.Router();
let database = require('../database/database');

/* GET users listing. */
router.get('/:id', async function (req, res, next) {
    return res.send(await database.getEvent(req.params.id));
});

module.exports = router;