const express = require('express');
const routes = require('./routes');
const bodyParser = require('body-parser');
const db = require('./utils');


// Cors permite que un cliente se conecta a otro servidor para el intercambio de recursos
const cors = require('cors');

// crear el servidor
const app = express();
//conectar a la mongo
//db();
db.connect(app);
const port = 3000;
// habilitar bodyparser
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

// Habilitar cors
app.use(cors());

// Rutas de la app

app.use('/', routes());

// carpeta publica
app.use(express.static('uploads'));

// puerto
app.on("ready", () => {
    app.listen(port, () => {
        console.log("Server is up on port", port);
    });
});