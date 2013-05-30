describe "VisitsPerAuthor", ->
  describe ".results", ->
    describe "totals visits for an author", ->
      Given -> @pageVisits = 
        [{'page':'post1','result':3},
         {'page':'post2','result':5}]
      Given -> @postAuthors = {'post1':'jturnbull','post2':'jturnbull'}
      When -> @visitsPerAuthor = new blogRanking.VisitsPerAuthor(@pageVisits,@postAuthors)
      Then -> expect(@visitsPerAuthor.results()['jturnbull']).toEqual(8)
