describe "AuthorCollection", ->

  describe ".compileVisits", ->
    describe "totals visits for each author", ->
      Given -> @posts = 
        [{'url':'/post1','author':'jturnbull','visits':'3','timeOnSite':'1397.0'},
         {'url':'/post2','author':'cdmwebs','visits':'5','timeOnSite':'456.0'},
         {'url':'/post3','author':'jturnbull','visits':'6','timeOnSite':'98.0'},
         {'url':'/post4','author':'cdmwebs','visits':'6','timeOnSite':'33.0'},]
      And -> @authors = new blogRanking.AuthorCollection
      Then -> expect(@authors.compileVisits(@posts)).toEqual(
        [{'name':'cdmwebs','visits':11},
         {'name':'jturnbull','visits':9},])

    describe "skips posts that are missing authors", ->
      Given -> @posts = 
        [{'url':'/post1','author':'jturnbull','visits':'3'},
         {'url':'/post2','author':'cdmwebs','visits':'5'},
         {'url':'/post3','author':undefined,'visits':'6'},
         {'url':'/post4','author':'cdmwebs','visits':'6'}]
      And -> @authors = new blogRanking.AuthorCollection
      Then -> expect(@authors.compileVisits(@posts)).toEqual(
        [{'name':'cdmwebs','visits':11},
         {'name':'jturnbull','visits':3},])

  describe ".compileEngagements", ->
    describe "totals engagements for each author", ->
      Given -> @posts = 
        [{'url':'/post1','author':'jturnbull','visits':'3','timeOnSite':'1397.0'},
         {'url':'/post2','author':'cdmwebs','visits':'5','timeOnSite':'456.0'},
         {'url':'/post3','author':'jturnbull','visits':'6','timeOnSite':'98.0'},
         {'url':'/post4','author':'cdmwebs','visits':'6','timeOnSite':'33.0'},]
      And -> @authors = new blogRanking.AuthorCollection
      Then -> expect(@authors.compileEngagements(@posts)).toEqual(
        [{'name':'jturnbull','timeOnSite':1495},
         {'name':'cdmwebs','timeOnSite':489},])
