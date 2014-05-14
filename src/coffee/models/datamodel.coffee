class DataModel extends KDObject

  constructor : (data, options = {}) ->

    super options, data

    {DB} = KD.singletons

    DB.collection(@getData()["collection"]).get data._id, (err, _data) =>

      data               = _data or data
      data.modelInstance = this

      @setData data

      @emit 'dataready', @getData()


  set : (key, value, permanent = true) ->

    data        = @getData()
    data[key]   = value

    @setData data

    @save() if permanent

    @emit 'datachanged' , @getData()


  save : ->

    {DB} = KD.singletons

    data = {}

    for k, v of @getData()
      unless k is 'modelInstance'
        data[k] = v

    DB.collection('articles').save data

    @emit 'datasaved', @getData()
