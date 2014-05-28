class MainViewController extends KDViewController

  constructor: (options = {}, data) ->

    super options, data

    @on 'requestloading', @getView().bound '_showLoading'
    @on 'requestloadingend', @getView().bound '_hideLoading'

    @articlesListController = new ArticlesListController


  getListController : -> @articlesListController
