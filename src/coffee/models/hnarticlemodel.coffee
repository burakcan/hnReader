class HnArticleModel extends DataModel

  constructor: (data, options = {}) ->

    data._id                 = data.id
    data.type                = 'hnarticle'
    data.collection          = 'articles'

    super data, options







