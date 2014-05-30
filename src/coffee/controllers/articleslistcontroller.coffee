class ArticlesListController extends KDListViewController

  constructor : (options = {}, data = {}) ->

    options.ownScrollBars  = yes
    options.viewOptions    =
      itemClass            : ArticlesListItemView
      type                 : 'articles-list'
      cssClass             : 'inner-container'

    options.noItemFoundWidget   = new KDCustomHTMLView
      partial                   : 'There is no article here :('
      cssClass                  : 'no-article-view'

    super options, data


  loadView:->

    super

    @hideNoItemWidget()


  registerItem: (view, index) ->
    super view, index

    view.on 'titleclicked', =>

      @emit 'articleclicked', view.getData()

      view.getData()['read'] = 'true'


  createList : (data, modelClass) ->

    @removeAllItems()

    {mainView} = KD.singletons

    mainView.emit 'requestloading', this.getView()

    KD.utils.wait 1000, =>

      for itemData in data

        model = new modelClass itemData

        model.on 'ready', @bound 'addItem'

    KD.utils.wait 1050, =>

      @showNoItemWidget() unless data.length

      mainView.emit 'requestloadingend', this.getView()
