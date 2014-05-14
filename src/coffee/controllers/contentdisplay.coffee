class ContentDisplay extends KDController

  constructor: (options = {}, data) ->

    super options, data


  showContent : (data) ->

    {title}   = data

    new KDModalView
      title     : title
      overlay   : yes
      draggable : no
      width     : '100%'
      height    : '100%'
      cssClass  : 'content-display'
      view      : new ContentDisplayFrameView {}, data

