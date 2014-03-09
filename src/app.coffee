koa = require 'koa'
app = koa()

app.use ->*
  @body = 'Hello World'

app.listen 3000
