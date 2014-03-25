app = require '../'
request = require 'supertest'
  .agent app.listen()

describe 'GET /', ->
  it 'should respond with a view', (done) ->
    request
      .get '/'
      .expect 200, done

describe 'GET /api/:id', ->
  it 'should respond with json containing id', (done) ->
    request
      .get '/api/5'
      .expect 'Content-Type', /json/
      .expect 200
      .expect
        id: 5
        query: {}
      .end done

describe 'GET /nowhere', ->
  it 'should return 404', (done) ->
    request
      .get '/nowhere'
      .expect 404, done
