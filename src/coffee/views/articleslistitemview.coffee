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

    @favoriteIcon = new KDToggleButton
      iconOnly      : yes
      defaultState  : 'Unfavorite' if @getData()['favorited']
      states        : [
        {
          title     : 'Favorite'
          cssClass  : 'icon-heart-empty'
          callback  : =>
            @favoriteIcon.setState 'Unfavorite'
            @emit 'favoritedstatechanged', 'true'
        }

        {
          title     : 'Unfavorite'
          cssClass  : 'icon-heart'
          callback  : =>
            @favoriteIcon.setState 'Favorite'
            @emit 'favoritedstatechanged', no
        }
      ]
    , @getData()

    @shareButton    = new KDButtonView
      iconOnly      : yes
      cssClass      : 'icon-export'
      callback      : =>

    @getData().on 'update', =>

      @render()

      if @getData()['favorited']
      then @favoriteIcon.setState 'Unfavorite'
      else @favoriteIcon.setState 'Favorite'


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

      <div class='article-info'>
        <span><em>{{ #(points) }}</em> points and <em>{{ #(comments_count) }}</em> comments</span>
        <span>Posted <em>{{ #(time_ago) }}</em> by <em>{{ #(user) }}</em></span>
      </div>
    """
