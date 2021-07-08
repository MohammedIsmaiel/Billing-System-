
const mysql = require('mysql');

// Create connection
const db = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DBNAME
});
// Connect
db.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('MySql Connected...');
});


const cookieParser = require('cookie-parser');
const express = require("express"),
    path = require('path'),
    hbs = require('hbs'),
    port = process.env.PORT || 5000;
const app = express();
app.listen(port)


app.use(express.json())
app.use(cookieParser())
// app.use(bodyParser());
app.use(express.urlencoded({ extended: true }))
app.use(express.static(path.join(__dirname, '../assets')))


//project paths
const assets = path.join(__dirname, '../assets')
const views = path.join(__dirname, './templates/views')
const partials = path.join(__dirname, './templates/partials')

//template engine settings
app.set('view engine', 'hbs')
app.set('views', views)
hbs.registerPartials(partials)
hbs.registerHelper('json', function (context) {
    return JSON.stringify(context);
});


app.get("/log-in", (req, res) => {
    res.render('log-in')
});

app.get("/bill", (req, res) => {
    res.render('bill')
});

app.get("/Add_patient", (req, res) => {
    res.render('Add_patient')
});

app.get("/Edit_patient", (req, res) => {
    res.render('Edit_patient')
});

app.get("/home", (req, res) => {
    res.render('home')
});

app.get("/sign-up", (req, res) => {
    res.render('sign-up')
});


app.get("/get-patients", (req, res) => {
        var sql = "SELECT * FROM `billing system`.patient;";
        db.query(sql, function (err, result) {
            if (err) throw err;
            console.log(result);
            res.render('patients',{
                re:result[0]
            })
        });

});

app.get("/*", (req, res) => {
    res.render('404')
});
    
