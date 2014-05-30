class ContentDisplay extends KDController

  constructor: (options = {}, data) ->

    super options, data


  showContent : (data) ->

    @modal?.destroy()

    @modal = new ContentDisplayView {}, data

