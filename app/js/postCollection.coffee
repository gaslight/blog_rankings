class blogRanking.PostCollection

  constructor: (@posts) ->

  postWithUrl: (url) -> 
    post = _.detect(@posts, (post) -> post.url == url)
    if post then post else {'url':url,'author':undefined}

  applyVisits: (data) ->
    @posts = for row in data
      url    = row[0]
      visits = row[1]

      post = @postWithUrl(url)
      post.visits = visits
      post
