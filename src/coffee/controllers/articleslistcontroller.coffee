class ArticlesListController extends KDListViewController

  constructor : (options = {}, data = {}) ->

    options.ownScrollBars  = yes
    options.viewOptions    =
      itemClass            : ArticlesListItemView
      type                 : 'articles-list'
      cssClass             : 'inner-container'

    super options, data


  registerItem: (view, index) ->
    super view, index

    view.on 'titleclicked', =>

      @emit 'articleclicked', view.getData()

      unless view.getData()['read']
        view.getData().modelInstance.set('read', true)
        view.setClass 'read'


    view.on 'favoritedstatechanged', (state) =>

      view.getData().modelInstance.set('favorited', state)

