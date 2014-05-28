class MainView extends KDView

  constructor: (options = {}, data) ->
    options.cssClass = 'main-view'
    options.tagName  = 'main'

    super options, data

    @header           = new MainHeaderView

    @header.on 'stateselect', (state) => @emit 'stateselect', state

    @appendToDomBody()


  viewAppended : ->
    @addSubView @header
    @addSubView @listView = KD.singletons.mainView.getListController().getView()


  _showLoading : (view) ->

    if view.loaderView
      view.loaderView.show()

    else
      view.addSubView view.loaderView = new KDLoaderView
        showLoader      : yes
        loaderOptions   :
          shape         : 'spiral'
          color         : '#ff6600'


  _hideLoading : (view) ->
    view.loaderView?.hide()
