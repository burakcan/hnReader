class ContentController extends KDController

  constructor: (options = {}, data) ->

    options.defaultState  = 'hnPopular'
    options.states        =
      'hnPopular'         :
        title             : 'Popular articles'
        type              : 'ajax'
        stateData         :
          url             : 'http://node-hnapi.herokuapp.com/news'
          dataModel       : HnArticleModel
      'hnNewest'          :
        type              : 'ajax'
        title             : 'Newest articles'
        stateData         :
          url             : 'http://node-hnapi.herokuapp.com/newest'
          dataModel       : HnArticleModel
      'hnFavorites'       :
        title             : 'Favorited articles'
        type              : 'local'
        stateData         :
          dataModel       : HnArticleModel
          filter          :
            type          : 'hnarticle'
            favorited     : 'true'

    super options, data

    @setState @getOption 'defaultState'


  setState : (stateName) ->

    state = @getOption('states')[stateName]

    return unless state

    return if stateName is @currentState

    @currentState = stateName

    {type, stateData} = state

    @["get#{type}"] stateData

    @once 'contentready', (data) -> @emit 'statechange', data, stateData


  getajax : (stateData) ->

    {url}   = stateData

    request = new Ajax url : url

    request.on 'datafetched', (data) =>

      @emit 'contentready', data

      @setData data


  getlocal : (stateData) ->

    {DB} = KD.singletons

    DB.collection('articles').find(stateData.filter).toArray (err, data) =>

        @emit 'contentready', data

        @setData data
