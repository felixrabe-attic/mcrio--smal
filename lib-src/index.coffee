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
  parse: (input) ->
    if input
      [[input.trim(), []]]
    else
      []

module.exports = {Parser}

