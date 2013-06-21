class blogRanking.AuthorCollection

  @knownAuthorNames: -> 
    [
      'jturnbull',
      'agilous',
      'cdmwebs',
      'dewaynegreenwood',
      'dougalcorn',
      'mysterycoder',
      'rockwoo',
      'ryan-gaslight',
      'st23am',
      'kristinlasita',
      'mitchlloyd',
      'nockitoff',
      'pkananen',
      'tammygambrel',
      'heflinao',
    ]
  
  constructor: (@postCollection) -> 

  assignPosts: (@postCollection) ->

  all: ->
    postedAuthors = @postedAuthors()
    otherKnownAuthors = @otherKnownAuthors(postedAuthors)
    _.union(postedAuthors,otherKnownAuthors)

  postedAuthors: ->  
    _.uniq(
      _.select(
        _.collect(@postCollection.all(),(post) -> post.author),
        (author) -> author.name))

  otherKnownAuthors: (postedAuthors) -> 
    result = for authorName in @constructor.knownAuthorNames()
      if author = _.detect(postedAuthors,(author) -> author.name == authorName) 
        author
      else
        new blogRanking.Author(authorName)
    result || []

  findOrCreateByName: (name) -> 
    author = _.detect(@all(), (author) -> author.name == name)
    if author 
      author 
    else 
      new blogRanking.Author(name)

  totalVisits: (author) ->
    posts = @postCollection.findByAuthor(author)
    postsWithVisits = _.select(posts, (post) -> post.visits)
    iterator = (accumulator,post) -> accumulator + parseInt(post.visits)
    _.reduce(postsWithVisits,iterator,0)

  avgTimeOnSite: (author) ->
    posts = @postCollection.findByAuthor(author)
    postsWithTimeOnSite = _.select(posts, (post) -> post.timeOnSite)
    iterator = (accumulator,post) -> accumulator + parseInt(post.timeOnSite)
    totalEngagement = _.reduce(postsWithTimeOnSite,iterator,0)
    totalEngagement / postsWithTimeOnSite.length

  totalPosts: (author) ->
    @postCollection.findByAuthor(author).length

  sortDescending: (sortAttribute) -> 
    _.sortBy(
      _.select(
        @postCollection.authors(), 
        (author) -> author.name and sortAttribute(author) > 0), 
      (author) -> 0 - sortAttribute(author)).slice(0,4)

  byTotalVisits: ->
    @sortDescending((author) => @totalVisits(author))

  byAvgTimeOnSite: ->
    @sortDescending((author) => @avgTimeOnSite(author))

  byPostsCount: ->
    @sortDescending((author) => @totalPosts(author))

