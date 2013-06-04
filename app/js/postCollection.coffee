class blogRanking.PostCollection

  constructor: (posts) ->
    @posts = for post in posts
      author = new blogRanking.Author(post.author.name)
      new blogRanking.Post(post.url,author)

  all: ->
    @posts

  byVisits: ->
    _.sortBy(
      _.select(@posts,(post) -> post.visits),
      (post) -> 0 - parseInt(post.visits)
    ).slice(0,9)

  byTimeOnSite: ->
    _.sortBy(
      _.select(@posts,(post) -> post.timeOnSite),
      (post) -> 0 - parseInt(post.timeOnSite)
    ).slice(0,9)

  findByUrl: (url) -> 
    post = _.detect(@posts, (post) -> post.url == url)

  applyVisits: (data) ->
    @applyData(data, (post,result) -> post.visits = result)

  applyTimeOnSite: (data) ->
    @applyData(data, (post,result) -> post.timeOnSite = parseInt(result))

  applyData: (data,apply) ->
    for row in data
      url    = row[0]
      result = row[1]

      post = @findByUrl(url)
      unless post
        author = new blogRanking.Author(undefined)
        post = new blogRanking.Post(url,author)
        @posts.push(post)
      apply(post,result) 
      post

