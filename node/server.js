const Path = require('path');
var rfs = require('rotating-file-stream')
const fs = require('fs');
let env = process.env.NODE_ENV || 'dev'
var proxy = require('express-http-proxy');
var morgan = require('morgan')

//node service.js --p medical-web
const args = process.argv.slice(2).reduce((acc, arg, cur, arr) => {
  if (arg.match(/^--/)) {
    acc[arg.substring(2)] = true
    acc['_lastkey'] = arg.substring(2)
  } else if (arg.match(/^-[^-]/)) {
    for (key of arg.substring(1).split('')) {
      acc[key] = true
      acc['_lastkey'] = key
    }
  } else if (acc['_lastkey']) {
    acc[acc['_lastkey']] = arg
    delete acc['_lastkey']
  } else
    acc[arg] = true
  if (cur == arr.length - 1)
    delete acc['_lastkey']
  return acc
}, {});
const project = args['p'] || args['project']
console.log(project)
if (!project) {
  throw 'please choose project'
}

var config = require(`./deploy/${project}/config.json`)[env];

const express = require('express')
const app = express()
const port = config.port || 4200
var accessLogStream = rfs('access.log', {
  interval: '1d', // rotate daily
  path: Path.join(__dirname, 'log')
})

app.use(morgan('combined', {stream: accessLogStream}))

app.use(express.static(__dirname + `/dist/${project}`, {
  'index': false,
  'maxAge': 3600000
}),)
app.set('views', Path.join(__dirname, 'dist', project));
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');

app.use(config.api_path, proxy(`${config.api_host}:${config.api_port}`, {
  limit: "120mb",
  proxyReqPathResolver: (req) => {
    let parts = req.url.split('?');
    let queryString = parts[1];
    let updatedPath = parts[0]
    return config.api_path + updatedPath + (queryString ? '?' + queryString : '')
  }
}));

app.get("*", (req, res) => {
  res.render(config.index || 'index')
})

app.listen(port, () => console.log(`app listening on port ${port}!`))

