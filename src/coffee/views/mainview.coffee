class MainView extends KDView

  constructor: (options = {}, data) ->
    options.cssClass = 'main-view'
    options.tagName  = 'main'

    super options, data

    @header           = new MainHeaderView

    @appendToDomBody()


  viewAppended : ->
    @addSubView @header
    @addSubView @listView = KD.singletons.mainView.getListController().getView()



