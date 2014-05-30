class ArticlesListItemView extends KDListItemView

  constructor : (options = {}, data) ->

    options.type   = 'article'

    super options, data

    @setClass 'read' if @getData()['read']

    @titleView = new KDCustomHTMLView
      tagName : 'h2'
      partial : @getData().title
      click   : => @emit 'titleclicked'
    , @getData()

    @favoriteIcon   = new FavoriteView {}, @getData()

    @shareButton    = new KDButtonView
      iconOnly      : yes
      cssClass      : 'icon-export'
      callback      : =>

        @shareView.setClass 'active'
        @shareView.active   = true

        KD.singletons['windowController'].addLayer @shareView

        @shareView.once 'ReceivedClickElsewhere', ->
          @unsetClass 'active'
          @active     = false

    @shareView      = new ShareView {}, @getData()

    @getData().on 'update', => @render()


  render : (fields) ->
    super fields

    @setClass 'read' if @getData()['read']


  viewAppended : JView::viewAppended


  pistachio : ->

    """
      <span class='article-number'></span>
      {{> this.titleView }}

      <div class='article-actions'>
        {{> this.favoriteIcon }}
        {{> this.shareButton }}
      </div>

      {{> this.shareView }}

      <div class='article-info'>
        <span><em>{{ #(points) }}</em> points and <em>{{ #(comments_count) }}</em> comments</span>
        <span>Posted <em>{{ #(time_ago) }}</em> by <em>{{ #(user) }}</em></span>
      </div>
    """
