_ = require 'lodash'
pegParser = require './parser'

class Parser
  constructor: (@options = {}) ->
    return new Parser options unless @ instanceof Parser
    @options.includeAll ?= false
    @options.includeComments ?= false
    @options.includeBlankLines ?= false
    if @options.includeAll
      @options.includeComments = true
      @options.includeBlankLines = true

  getOptions: ->
    @options

  parseLine: (input) ->
    if input.indexOf('\n') > -1
      throw new Error 'parseLine() will not parse multiple lines'
    if input
      [[input.trim(), []]]
    else
      []

  parse: (string) ->
    ast = pegParser.parse string
    tree = []

    integrate = (level, res) ->
      parent = tree
      while level-- > 0
        parent = parent[parent.length - 1][1]
      parent.push res

    processRes = (res, baseLevel = 0) ->
      return if res[1] == null or res[1] == '//'
      level = res[0].length + baseLevel
      res = res[1..]
      if res.length == 1 and _.isArray(res[0])
        # special case for strings to make them less complex
        res = res[0]
      else if res.length == 2 and _.isArray(res[1])
        subRes = res[1]
        res[1] = []
        integrate level, res
        for sub in subRes
          processRes [ [] ].concat(sub), level + 1
        return
      integrate level, res

    processRes astPart for astPart in ast
    return tree

module.exports = {Parser}
