class ShareView extends KDView

  constructor: (options = {}, data) ->

    options.cssClass    = 'share-view'

    super options, data

    @facebook   = new KDCustomHTMLView
      cssClass    : 'icon icon-facebook'
      click       : => @showSharePopup 'Share on Facebook',  @getFacebookLink()

    @twitter   = new KDCustomHTMLView
      cssClass    : 'icon icon-twitter'
      click       : => @showSharePopup 'Tweet this',  @getTwitterLink()


  showSharePopup : (title, url) ->

    data = {}
    data.url = url

    @popup = new KDModalView
      overlay   : yes
      title     : title
      cssClass  : 'share-popup'
      height    : 400
      view      : new ContentDisplayFrameView {}, data


  getFacebookLink : ->

    {url, title} = @getData()

    url   = encodeURIComponent url
    title = encodeURIComponent title

    return "http://facebook.com/sharer.php?u=#{url}&t=#{title}"


  getTwitterLink : ->

    {url, title} = @getData()
    url     = encodeURIComponent url
    title   = encodeURIComponent title

    return "https://twitter.com/intent/tweet?url=#{url}&text=#{title}&via=hnapp"


  viewAppended : ->
    @addSubView @facebook
    @addSubView @twitter
