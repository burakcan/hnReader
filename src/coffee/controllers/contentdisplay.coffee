class ContentDisplay extends KDController

  constructor: (options = {}, data) ->

    super options, data


  showContent : (data) ->

    @on 'favoritedstatechanged', (state) -> data['favorited'] = state

    {title}     = data

    @modal?.destroy()

    @modal      = new KDModalView
      title     : title
      overlay   : yes
      draggable : no
      width     : '100%'
      height    : '100%'
      cssClass  : 'content-display'
      view      : new ContentDisplayFrameView {}, data

    @readabilityIcon = new KDToggleButton
      iconOnly      : yes
      defaultState  : 'Activate'
      states        : [
        {
          title     : 'Activate'
          cssClass  : 'icon-readability passive'
          callback  : =>
            @readabilityIcon.setState 'Passivate'
            @modal.options.view.activateReadability()

        }

        {
          title     : 'Passivate'
          cssClass  : 'icon-readability active'
          callback  : =>
            @readabilityIcon.setState 'Activate'
            @modal.options.view.passivateReadability()
        }
      ]

    @favoriteIcon = new KDToggleButton
      iconOnly      : yes
      defaultState  : 'Unfavorite' if data['favorited']
      states        : [
        {
          title     : 'Favorite'
          cssClass  : 'icon-heart-empty'
          callback  : =>
            @favoriteIcon.setState 'Unfavorite'
            @emit 'favoritedstatechanged', 'true'
        }

        {
          title     : 'Unfavorite'
          cssClass  : 'icon-heart'
          callback  : =>
            @favoriteIcon.setState 'Favorite'
            @emit 'favoritedstatechanged', no
        }
      ]

    @modal.$().find(".kdmodal-title").append @readabilityIcon.getElement()
    @modal.$().find(".kdmodal-title").append @favoriteIcon.getElement()

