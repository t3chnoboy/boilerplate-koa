var app, koa;

koa = require('koa');

app = koa();

app.use(function*() {
  return this.body = 'Hello World';
});

app.listen(3000);
