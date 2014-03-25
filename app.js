var app, json, koa, livereload, logger, parse, render, router, serve, session, views;

koa = require('koa');

parse = require('co-body');

json = require('koa-json');

views = require('co-views');

logger = require('koa-logger');

router = require('koa-router');

serve = require('koa-static');

session = require('koa-session');

livereload = require('koa-livereload');

app = koa();

app.use(logger());

app.use(json());

app.use(session());

app.use(livereload());

app.use(router(app));

render = views('views/');

app.use(serve('public/'));

require('koa-qs')(app);

app.get('/', function*() {
  return this.body = yield render('index.jade');
});

app.get('/api/:id', function*() {
  return this.body = {
    id: this.params.id,
    query: this.query
  };
});

app.listen(3000);
