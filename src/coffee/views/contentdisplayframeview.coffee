class ContentDisplayFrameView extends KDView

  constructor : (options = {}, data) ->

    options.cssClass = 'content-display-frame'

    super options, data

    @iframe = new KDCustomHTMLView
      tagName     : 'iframe'
      attributes  :
        nwdisable : 'true'
        nwfaketop : 'true'
        src       : @getData().url


  viewAppended : ->
    @addSubView @iframe


