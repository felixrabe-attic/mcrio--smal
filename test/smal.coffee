require('chai').should()

smal = require '../'

describe 'SMAL parser', ->
  it 'should parse empty input', ->
    smal.parse('').should.deep.equal []
