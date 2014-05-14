class MainViewController extends KDViewController

  constructor: (options = {}, data) ->

    super options, data

    @articlesListController = new ArticlesListController


  getListController : -> @articlesListController


  dataFetched : (data) ->

    @getListController().setData data

    @getListController().replaceAllItems data


