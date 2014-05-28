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

      view.getData()['read'] = 'true'

    view.on 'favoritedstatechanged', (state) -> view.getData()['favorited'] = state


  createList : (data, modelClass) ->

    @removeAllItems()

    KD.singletons.mainView.emit 'requestloading', this.getView()

    KD.utils.wait 1000, =>

      for itemData in data

        model = new modelClass itemData

        model.on 'ready', @bound 'addItem'

    KD.utils.wait 1050, => KD.singletons.mainView.emit 'requestloadingend', this.getView()
