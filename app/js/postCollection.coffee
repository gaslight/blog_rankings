class blogRanking.PostCollection

  constructor: (@posts) ->

  postWithUrl: (url) -> 
    post = _.detect(@posts, (post) -> post.url == url)
    if post then post else {'url':url,'author':undefined}

  applyVisits: (data) ->
    @applyData(data, (post,result) -> post.visits = result)

  applyTimeOnSite: (data) ->
    @applyData(data, (post,result) -> post.timeOnSite = parseInt(result))

  applyData: (data,apply) ->
    @posts = for row in data
      url    = row[0]
      result = row[1]

      post = @postWithUrl(url)
      apply(post,result) 
      post

