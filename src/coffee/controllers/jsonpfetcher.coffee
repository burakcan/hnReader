class JSONPFetcher extends KDController

  constructor: (options = {}, data) ->

    options.apiUrls      ?= []
    options.maxTry       ?= 5
    options.tryInterval  ?= 5000

    super options, data

    @tried = 0


  getJSONPObject : ->

    unless @JSONPObject

      @JSONPObject = new KDCustomHTMLView
        tagName     : 'script'

      @JSONPObject.appendToDomBody()

    return @JSONPObject


  fetch : (section) ->

    return unless section

    @getJSONPObject().setAttribute 'src', @getOption('apiUrls')[section]

    {tryInterval} = @getOptions()
    @tried        = @tried + 1

    @fetchTimeOutTimer = KD.utils.wait tryInterval, => @refresh section


  refresh : (section) ->
    @JSONPObject?.destroy()
    @JSONPObject = null

    return @error() if @tried is @getOption 'maxTry'

    @fetch section


  success : (data) ->

    @tried = 0

    KD.utils.killWait @fetchTimeOutTimer

    @setData data

    @emit 'datafetched', data


  error : ->

    @tried = 0

    @emit 'couldntfetch'

    log 'couldnt fetch feed'
