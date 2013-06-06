class blogRanking.AuthorCollection

  constructor: (@postCollection) -> 
    @authors = [
#      new blogRanking.Author('jturnbull'),
#      new blogRanking.Author('agilous'),
#      new blogRanking.Author('cdmwebs'),
#      new blogRanking.Author('dewaynegreenwood'),
#      new blogRanking.Author('dougalcorn'),
#      new blogRanking.Author('mysterycoder'),
#      new blogRanking.Author('rockwoo'),
#      new blogRanking.Author('ryan-gaslight'),
#      new blogRanking.Author('st23am'),
#      new blogRanking.Author('kristinlasita'),
#      new blogRanking.Author('mitchlloyd'),
#      new blogRanking.Author('nockitoff'),
#      new blogRanking.Author('pkananen'),
#      new blogRanking.Author('tammygambrel'),
    ]
  
  assignPosts: (@postCollection) ->

  all: ->
    _.uniq(_.collect(@postCollection.all(),(post) -> post.author))

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
    _.sortBy(_.select(@postCollection.authors(), (author) -> author.name), (author) -> 0 - sortAttribute(author))

  byTotalVisits: ->
    #_.sortBy(@postCollection.authors(), (author) => 0 - @totalVisits(author))

    @sortDescending((author) => @totalVisits(author))

  byAvgTimeOnSite: ->
    @sortDescending((author) => @avgTimeOnSite(author))

  byPostsCount: ->
    @sortDescending((author) => @totalPosts(author))

