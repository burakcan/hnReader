class DataModel extends KDObject

  constructor : (data, options = {}) ->

    options.alwaysUpdate ?= [] #A list of keys which we want always be updated with remote data

    super options, data

    {DB} = KD.singletons

    DB.collection(@getOption "collection").get data._id, (err, localData) =>

      if localData

        for key in @getOption 'alwaysUpdate'
          localData[key] = @getData()[key]

        @setData localData

      makeGetter = (key) -> -> @getData()[key]
      makeSetter = (key) -> (value) ->
        @getData()[key] = value
        @emit 'update'

      props = {}

      for own key, _ of @getData()
        props[key] =
          get: makeGetter key
          set: makeSetter key

      Object.defineProperties this, props

      @emit 'ready', this

    @on 'update', @bound 'save'


  save : ->

    {DB} = KD.singletons

    DB.collection(@getOption "collection").save @getData()

    @emit 'datasaved', this
