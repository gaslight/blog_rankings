class blogRanking.PostCollection
    
  initializePosts: (posts) ->
    @posts = []
    for post in posts
      post = post.doc
      author = @authorCollection().findOrCreateByName(post.author)
      @posts.push(new blogRanking.Post(post._id,post._rev,post.url,author))
    @

  all: ->
    @posts

  totalPosts: (author) -> 
    @authorCollection().totalPosts(author)

  avgTimeOnSite: (author) -> 
    @authorCollection().avgTimeOnSite(author)

  totalVisits: (author) -> 
    @authorCollection().totalVisits(author)

  authorCollection: ->
    new blogRanking.AuthorCollection(@)

  authors: ->
    @authorCollection().all()

  findByAuthor: (author) ->
    _.select(@posts, (post) -> post.author == author)

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
        post = new blogRanking.Post(undefined,undefined,url,author)
        @posts.push(post)
      apply(post,result) 
      post

