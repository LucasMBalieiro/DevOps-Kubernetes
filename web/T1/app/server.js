let express = require('express');
let path = require('path');
let fs = require('fs');
let MongoClient = require('mongodb').MongoClient;
let bodyParser = require('body-parser');
let app = express();

const DB_URL = process.env.DB_URL;
const DB_USER = process.env.USER_NAME
const DB_SENHA = process.env.USER_PWD

const mongoUrlWithAuth = `mongodb://${DB_USER}:${DB_SENHA}@${DB_URL}`;


app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());

app.get('/', function (req, res) {
    res.sendFile(path.join(__dirname, "index.html"));
  });



let mongoClient = { useNewUrlParser: true, useUnifiedTopology: true };





app.get('/fetch-data', function (req, res) {
  let resposta = {};
  MongoClient.connect(mongoUrlWithAuth, mongoClient, function (erro, client) {
    if (erro) throw erro;

    const db = client.db("devops1");
    const collection = db.collection("devops2");

    collection.findOne({ id: 1 }, function (err, result) {
      if (err) throw err;
      res.send(result ? result : {});
      client.close();
    });
  });
});

app.listen(3000, function () {
  console.log("listen port: 3000");
});

