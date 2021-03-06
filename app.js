const express = require('express');
const app = express();
const router = express.Router();
const http = require('http');
const cors = require('cors');
const path = __dirname + '/views/';
const port = process.env.PORT || 10000;
const db = require('./radon')

router.use(function (req,res,next) {
  console.log('/' + req.method);
  next();
});

router.get('/', function(req,res){
  res.sendFile(path + 'index.html');
});


app.get('/data/:year?', db.getData)

app.use(cors());
app.use(express.static(path));
app.use('/', router);

app.listen(port, function () {
  console.log('app listening on port ' + port)
})

