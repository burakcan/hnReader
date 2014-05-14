class HNFetcher extends JSONPFetcher

  constructor: (options = {}, data) ->

    options.apiUrls =
      # homeArticles     : 'http://api.ihackernews.com/page?format=jsonp&callback=KD.singletons.hnFetcher.success'
      homeArticles   : 'api.example.js'

    super options, data
