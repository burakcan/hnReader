class ContentDisplayFrameView extends KDView

  constructor : (options = {}, data) ->

    options.cssClass = 'content-display-frame'

    super options, data

    @iframe = new KDCustomHTMLView
      tagName     : 'iframe'
      attributes  :
        nwdisable : 'true'
        nwfaketop : 'true'
        src       : @getData().url


  passivateReadability : ->

    @iframe.show()

    @readabilityView?.hide()


  activateReadability : ->

    {mainView} = KD.singletons

    mainView.emit 'requestloading', this

    @iframe.hide()

    if @readabilityView

      @readabilityView.show()

      mainView.emit 'requestloadingend', this

    else

      apiUrl    = 'http://readability.com/api/content/v1/parser'
      apiToken  = '7548f666ef521d48e0e4a72a8c80e858e93fe3fd'
      pageUrl   = @getData().url

      ajax = new Ajax
        url     : "#{apiUrl}?url=#{pageUrl}&token=#{apiToken}"
        success : (data) =>
          KD.utils.wait 1000, =>
            @addSubView @readabilityView = new KDCustomHTMLView
              cssClass : 'readability-view'
              tagName  : 'article'

            @readabilityView.addSubView new KDCustomHTMLView
              tagName  : 'h1'
              cssClass : 'main-heading'
              partial  : data.title

            @readabilityView.addSubView new KDCustomHTMLView
              partial  : data.content

            mainView.emit 'requestloadingend', this


  viewAppended : ->

    {mainView} = KD.singletons

    mainView.emit 'requestloading', this

    @addSubView @iframe

    @iframe.getElement().onload = => mainView.emit 'requestloadingend', this

    KD.utils.wait 6000, => mainView.emit 'requestloadingend', this


