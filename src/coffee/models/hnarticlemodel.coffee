class HnArticleModel extends DataModel

  constructor: (data, options = {}) ->

    data._id                 = data._id or data.id
    data.type                = 'hnarticle'
    data.read                = false
    data.favorited           = false

    options.collection       = 'articles'
    options.alwaysUpdate     = [
      'points'
      'comments_count'
      'time_ago'
    ]

    delete data.id

    super data, options







