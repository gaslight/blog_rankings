class blogRanking.AuthorCollection

  constructor: (@posts) ->
    @authors = []
    for post in @posts
      if author = _.detect(@authors,(author) -> post.author.name == author.name)
        author.posts.push(post)
      else
        post.author.posts.push(post)
        @authors.push(post.author)

  all: ->
    @authors

  sortDescending: (sortAttribute) -> 
    _.sortBy(_.select(@all(), (author) -> author.name), (author) -> 0 - sortAttribute(author))

  byTotalVisits: ->
    @sortDescending((author) -> author.totalVisits())

  byAvgTimeOnSite: ->
    @sortDescending((author) -> author.avgTimeOnSite())

  byPostsCount: ->
    @sortDescending((author) -> author.totalPosts())

