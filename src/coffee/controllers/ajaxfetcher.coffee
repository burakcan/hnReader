class Ajax extends KDController

  constructor: (options = {}, data) ->

    options.url ?= ''

    super options, data

    @xmlHttp = new XMLHttpRequest

    @request @getOption 'url'


  request : (url) ->

    url = url or @getOption 'url'

    @xmlHttp.open 'get', url, true

    @xmlHttp.send()

    @xmlHttp.onreadystatechange = =>

      if @xmlHttp.readyState is 4

        if @xmlHttp.status is 200
        then @success JSON.parse @xmlHttp.responseText
        else @error()

    return @xmlHttp


  success : (data) ->

    @setData data

    @emit 'datafetched', data


  error : ->

    @emit 'couldntfetch'

    @request()
