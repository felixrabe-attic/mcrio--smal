# This file tests the tree format.

# TODO: Test the intermediary line format as well, and implement stream
#       parsing too.

they = it

require('chai').should()

index = require '../'

describe 'index.Parser.parseLine:', ->

  parseEqOpts = null
  parseEq = null

  before ->
    parseEqOpts = (options = {}) ->
      parser = index.Parser(options)
      (input, expected) ->
        if expected instanceof Error
          (->
            parser.parseLine(input)
          ).should.Throw Error
        else
          parser.parseLine(input).should.deep.equal expected
    parseEq = parseEqOpts()

  it 'should parse empty input', ->
    parseEq '', []

  it 'does not parse anything containing a newline character', ->
    parseEq '\n', new Error

  describe 'indentation syntax', ->
    it 'must be two spaces'

  describe 'options:', ->

    describe 'defaults:', ->
      options = null

      before ->
        parser = index.Parser()
        options = parser.getOptions()

      they 'should not include comments', ->
        options.includeComments.should.not.be.ok

      they 'should not include blank lines', ->
        options.includeBlankLines.should.not.be.ok

    describe 'options.includeComments', ->
    describe 'options.includeBlankLines', ->
    describe 'options.includeAll', ->

  describe 'elements:', ->

    describe 'one empty element', ->
      it 'is parsed from a character', ->
        parseEq 'a', [['a', []]]

      it 'is parsed from a word', ->
        parseEq 'foo', [['foo', []]]

    describe 'two elements', ->
      they 'cannot be parsed due to a newline character', ->
        parseEq 'foo\nbar', new Error

    describe 'nested elements', ->
      they 'are parsed from one line with two words'

  describe 'strings', ->

    they 'are parsed from quoted character sequences'

  describe 'groups', ->

    they 'are parsed from braced expressions within a line'

  describe 'comments:', ->

    describe 'when included (options.includeComments):', ->
      pe = null
      before -> pe = parseEqOpts includeComments: true

      they 'begin with //'

    describe 'when omitted (!options.includeComments):', ->
      pe = parseEq

      they 'begin with //'

describe 'index.Parser.parse:', ->

  parseEqOpts = null
  parseEq = null

  before ->
    parseEqOpts = (options = {}) ->
      parser = index.Parser(options)
      (input, expected) ->
        parser.parse(input).should.deep.equal expected
    parseEq = parseEqOpts()

  it 'should parse empty input', ->
    parseEq '', []

  describe 'indentation syntax', ->
    it 'must be two spaces'

  describe 'options:', ->

    describe 'defaults:', ->
      options = null

      before ->
        parser = index.Parser()
        options = parser.getOptions()

      they 'should not include comments', ->
        options.includeComments.should.not.be.ok

      they 'should not include blank lines', ->
        options.includeBlankLines.should.not.be.ok

    describe 'options.includeComments', ->
    describe 'options.includeBlankLines', ->
    describe 'options.includeAll', ->

  describe 'elements:', ->

    describe 'one empty element', ->
      it 'is parsed from a character', ->
        parseEq 'a', [['a', []]]
        parseEq 'a\n', [['a', []]]

      it 'is parsed from a word', ->
        parseEq 'foo', [['foo', []]]
        parseEq 'bar\n', [['bar', []]]

    describe 'two elements', ->
      they 'are parsed from two single-word lines'

    describe 'nested elements', ->
      they 'are parsed from one line with two words'

      they 'are parsed from a single-word line folloed by an indented single-word line'
        # parseEq '''
        #   one
        #     two
        #       three
        # ''', [
        #   ['one', [
        #     ['two', [
        #       ['three', []]
        #     ]]
        #   ]]
        # ]

  describe 'strings', ->

    they 'are parsed from quoted character sequences'

  describe 'groups', ->

    they 'are parsed from braced expressions within a line'

  describe 'comments:', ->

    describe 'when included (options.includeComments):', ->
      pe = null
      before -> pe = parseEqOpts includeComments: true

      they 'begin with //'

      they 'are parsed when in their own lines'

      they 'are parsed between other lines'

    describe 'when omitted (!options.includeComments):', ->
      pe = parseEq

      they 'begin with //'

      they 'are parsed when in their own lines'

      they 'are parsed between other lines'

  describe 'blank lines:', ->

    describe 'when included (options.includeBlankLines):', ->
      pe = null
      before -> pe = parseEqOpts includeBlankLines: true

      they 'are parsed at the beginning of input'

      they 'are parsed at the end of input'

      they 'are parsed in-between elements'

      they 'are parsed at the beginning of indented blocks'

      they 'are parsed at the end of indented blocks'

    describe 'when omitted (!options.includeBlankLines):', ->
      pe = parseEq

      they 'are parsed at the beginning of input'

      they 'are parsed at the end of input'

      they 'are parsed in-between elements'

      they 'are parsed at the beginning of indented blocks'

      they 'are parsed at the end of indented blocks'
