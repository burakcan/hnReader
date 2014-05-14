class ArticlesListItemView extends KDListItemView

  constructor : (options = {}, data) ->

    options.type   = 'article'

    super options, data

    @setClass 'read' if @getData()['read']

    @titleView = new KDCustomHTMLView
      tagName : 'h2'
      partial : @getData().title
      click   : => @emit 'titleclicked'

    @favoriteIcon = new KDToggleButton
      iconOnly      : yes
      defaultState  : 'Unfavorite' if @getData()['favorited']
      states        : [
        {
          title     : 'Favorite'
          cssClass  : 'icon-star-empty'
          callback  : =>
            @favoriteIcon.toggleState()
            @emit 'favoritedstatechanged', yes
        }

        {
          title     : 'Unfavorite'
          cssClass  : 'icon-star'
          callback  : =>
            @favoriteIcon.toggleState()
            @emit 'favoritedstatechanged', no
        }
      ]

    @shareButton    = new KDButtonView
      iconOnly      : yes
      cssClass      : 'icon-export'

    @getData().modelInstance.on 'datachanged', log


  viewAppended : JView::viewAppended


  pistachio : ->
    {title, points, commentCount, postedAgo, postedBy} = @getData()

    """
      <span class='article-number'></span>
      {{> this.titleView }}

      <div class='article-actions'>
        {{> this.favoriteIcon }}
        {{> this.shareButton }}
      </div>

      <div class='article-info'>
        <span><em>#{points}</em> points and <em>#{commentCount}</em> comments</span>
        <span>Posted <em>#{postedAgo}</em> by <em>#{postedBy}</em></span>
      </div>
    """
