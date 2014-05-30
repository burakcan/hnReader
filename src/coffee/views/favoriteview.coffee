class FavoriteView extends KDToggleButton

  constructor : (options = {}, data) ->

    options.iconOnly      = yes
    options.defaultState  = 'Unfavorite' if data['favorited']
    options.states        = [
      {
        title     : 'Favorite'
        cssClass  : 'icon-heart-empty'
        callback  : ->
          @setState 'Unfavorite'
          @getData()['favorited'] = 'true'

      }

      {
        title     : 'Unfavorite'
        cssClass  : 'icon-heart'
        callback  : ->
          @setState 'Favorite'
          @getData()['favorited'] = no
      }
    ]

    super options, data
