class ContentDisplayView extends KDModalView

  constructor: (options = {}, data) ->

    options.title     = data.title
    options.overlay   = yes
    options.draggable = no
    options.width     = '100%'
    options.height    = '100%'
    options.cssClass  = 'content-display'
    options.view      = new ContentDisplayFrameView {}, data

    super options, data

    @getView().activateReadability() if @getData()['readability']


  getView : -> @getOption 'view'


  viewAppended : ->

    @readabilityIcon = new KDToggleButton
      iconOnly      : yes
      defaultState  : 'Passivate' if @getData()['readability']
      states        : [
        {
          title     : 'Activate'
          cssClass  : 'icon-readability passive'
          callback  : =>
            @readabilityIcon.setState 'Passivate'
            @getView().activateReadability()
        }

        {
          title     : 'Passivate'
          cssClass  : 'icon-readability active'
          callback  : =>
            @readabilityIcon.setState 'Activate'
            @getView().passivateReadability()
        }
      ]

    @favoriteIcon = new FavoriteView {}, @getData()

    @$().find(".kdmodal-title").append @readabilityIcon.getElement()
    @$().find(".kdmodal-title").append @favoriteIcon.getElement()



