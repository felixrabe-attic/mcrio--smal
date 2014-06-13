class Parser
  constructor: (@options = {}) ->
    return new Parser options unless @ instanceof Parser
    @options.includeAll ?= false
    @options.includeComments ?= false
    @options.includeBlankLines ?= false
    if @options.includeAll
      @options.includeComments = true
      @options.includeBlankLines = true
  parse: (input) ->
    if input
      [[input.trim(), []]]
    else
      []
  getOptions: ->
    @options

module.exports = {Parser}

