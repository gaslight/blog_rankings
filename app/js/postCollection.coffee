class blogRanking.PostCollection

  constructor: (@posts) ->

  postWithUrl: (url) -> 
    post = _.detect(@posts, (post) -> post.url == url)
    if post then post else {'url':url,'author':undefined}

  applyVisits: (data) ->
    @applyData(data, (post,result) -> post.visits = result)

  applyTimeOnSite: (data) ->
    @applyData(data, (post,result) -> post.timeOnSite = formatSecondsToMinutes(result))

  applyData: (data,apply) ->
    @posts = for row in data
      url    = row[0]
      result = row[1]

      post = @postWithUrl(url)
      apply(post,result) 
      post

  formatSecondsToMinutes = (value) -> 
    minutes = Math.floor(value / 60)
    seconds = Math.round(value % 60)
    minuteString = minutes.toString()
    secondString = if seconds < 10 then "0" + seconds.toString() else seconds.toString()
    minuteString + ":" + secondString 

