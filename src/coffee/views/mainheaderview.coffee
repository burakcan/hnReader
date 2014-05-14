class MainHeaderView extends KDView

  constructor : (options = {}, data) ->
    options.tagName   = 'header'
    options.cssClass  = 'main-header'

    super options, data

    @innerContainer = new KDCustomHTMLView
      cssClass   : 'inner-container'

    @logo = new KDCustomHTMLView
      tagName    : 'figure'
      cssClass   : 'logo'


  viewAppended : ->
    @addSubView @innerContainer
    @innerContainer.addSubView @logo
