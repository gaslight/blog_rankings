describe "PostCollection", ->
  Given -> @authorData = 
    [{'url':'/post1','author':'jturnbull'},
     {'url':'/post2','author':'cdmwebs'}]
  And -> @postCollection = new blogRanking.PostCollection(@authorData)
  describe ".posts", ->
    Then -> expect(@postCollection.posts).toEqual(@authorData)
  describe ".applyVisits", ->
    describe "merges visit data into post", ->
      Given -> @data =
        [['/post1',3],
         ['/post2',5]]
      When -> @postCollection.applyVisits(@data)
      Then -> expect(@postCollection.posts).toEqual(
        [{'url':'/post1','author':'jturnbull','visits':3},
         {'url':'/post2','author':'cdmwebs','visits':5}])
    describe "creates a post with visit data where no author has been set", ->
      Given -> @data =
        [['/post1',3],
         ['/post2',5],
         ['/post3',6]]
      When -> @postCollection.applyVisits(@data)
      Then -> expect(@postCollection.posts).toEqual(
        [{'url':'/post1','author':'jturnbull','visits':3},
         {'url':'/post2','author':'cdmwebs','visits':5},
         {'url':'/post3','author':undefined,'visits':6}])
  describe ".applyTimeOnSite", ->
    describe "merges data into post", ->
      Given -> @xdata =
        [['/post1','1379.0'],
         ['/post2','169.0']]
      When -> @postCollection.applyTimeOnSite(@xdata)
      Then -> expect(@postCollection.posts).toEqual(
        [{'url':'/post1','author':'jturnbull','timeOnSite':'22:59'},
         {'url':'/post2','author':'cdmwebs','timeOnSite':'2:49'}])
