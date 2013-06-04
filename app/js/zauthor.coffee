class blogRanking.Author

  constructor: (@name) ->
    @posts = []

  totalVisits: ->
    postsWithVisits = _.select(@posts, (post) -> post.visits)
    iterator = (accumulator,post) -> accumulator + parseInt(post.visits)
    _.reduce(postsWithVisits,iterator,0)

  avgTimeOnSite: ->
    postsWithTimeOnSite = _.select(@posts, (post) -> post.timeOnSite)
    iterator = (accumulator,post) -> accumulator + parseInt(post.timeOnSite)
    totalEngagement = _.reduce(postsWithTimeOnSite,iterator,0)
    totalEngagement / postsWithTimeOnSite.length

  totalPosts: ->
    @posts.length
