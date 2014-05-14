do ->

  KD.registerSingleton 'mainView', new MainViewController view : new MainView

  KD.registerSingleton 'hnFetcher', new HNFetcher

  KD.registerSingleton 'contentDisplay', new ContentDisplay

  KD.registerSingleton 'DB', bongo.db
    name        : 'newshere'
    collections : ['articles']


  {mainView, hnFetcher, contentDisplay, DB} = KD.singletons


  hnFetcher.on 'datafetched', (data) ->

    for itemData in data.items

      model = new HnArticleModel itemData

      model.on 'dataready', mainView.getListController().bound 'addItem'

  hnFetcher.fetch('homeArticles')


  mainView.getListController().on 'articleclicked', contentDisplay.bound 'showContent'
