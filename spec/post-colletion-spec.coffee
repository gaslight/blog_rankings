describe "PostCollection", ->
  Given -> @data = 
    [{'url':'/post1','author':'jturnbull'},
     {'url':'/post2','author':'cdmwebs'}]
  And -> @postCollection = new blogRanking.PostCollection(@data)
  describe ".posts", ->
    Then -> expect(@postCollection.posts).toEqual(@data)
  describe ".applyVisits", ->
    describe "with data", ->
      Given -> @visitData =
        [['/post1',3],
         ['/post2',5]]
      When -> @postCollection.applyVisits(@visitData)
      Then -> expect(@postCollection.posts).toEqual(
        [{'url':'/post1','author':'jturnbull','visits':3},
         {'url':'/post2','author':'cdmwebs','visits':5}])
    describe "missing data", ->
      Given -> @visitData =
        [['/post1',3],
         ['/post2',5],
         ['/post3',6]]
      When -> @postCollection.applyVisits(@visitData)
      Then -> expect(@postCollection.posts).toEqual(
        [{'url':'/post1','author':'jturnbull','visits':3},
         {'url':'/post2','author':'cdmwebs','visits':5},
         {'url':'/post3','author':undefined,'visits':6}])
     
