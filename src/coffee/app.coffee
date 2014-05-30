do ->

  KD.registerSingleton 'DB', bongo.db
    name        : 'newshere'
    collections : ['articles']

  KD.registerSingleton 'contentController', new ContentController

  KD.registerSingleton 'contentDisplay', new ContentDisplay

  KD.registerSingleton 'mainView', new MainViewController view : new MainView


  {mainView, contentDisplay, contentController} = KD.singletons

  mainView.emit 'requestloading', mainView.getListController().getView()

  mainView.getView().on 'stateselect', contentController.bound 'setState'
  mainView.getView().on 'stateselect', mainView.getListController().bound 'removeAllItems'
  mainView.getView().on 'stateselect', mainView.getListController().bound 'hideNoItemWidget'
  mainView.getView().on 'stateselect', -> mainView.emit 'requestloading', mainView.getListController().getView()

  contentController.on 'statechange', (data, stateData) ->
    mainView.getListController().createList(data, stateData.dataModel)

  mainView.getListController().on 'articleclicked', contentDisplay.bound 'showContent'
