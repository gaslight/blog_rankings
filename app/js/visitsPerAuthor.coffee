class blogRanking.VisitsPerAuthor

  constructor: (@pageVisits,@postAuthors) ->

  results: ->
    visitsPerAuthor = {}
    for pageVisit in @pageVisits
      if author = @postAuthors[pageVisit.page]
        if totalVisits = visitsPerAuthor[author]
          totalVisits = totalVisits + pageVisit.result
          visitsPerAuthor[author] = totalVisits
        else
          visitsPerAuthor[author] = pageVisit.result
    visitsPerAuthor
    


      

    {'jturnbull':8}
