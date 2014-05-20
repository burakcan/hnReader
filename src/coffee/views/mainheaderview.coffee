class MainHeaderView extends KDView

  constructor : (options = {}, data) ->
    options.tagName   = 'header'
    options.cssClass  = 'main-header'

    super options, data

    @innerContainer = new KDCustomHTMLView
      cssClass   : 'inner-container'

    {states, defaultState}    = KD.singletons['contentController'].getOptions()

    statesArray = []

    for key, item of states
      item['value'] = key
      statesArray.push item

    @stateSelector  = new KDSelectBox
      name          : 'state-selector'
      cssClass      : 'state-selector'
      selectOptions : statesArray
      change        : => @emit 'stateselect', @stateSelector.getValue()

    @logo = new KDCustomHTMLView
      tagName    : 'figure'
      cssClass   : 'logo'


  viewAppended : ->
    @addSubView @innerContainer
    @innerContainer.addSubView @logo
    @innerContainer.addSubView @stateSelector
