describe "PostCollection", ->
  Given -> @author1 = new blogRanking.Author('jturnbull')
  Given -> @author2 = new blogRanking.Author('cdmwebs')
  Given -> @author3 = new blogRanking.Author()
  Given -> @author4 = new blogRanking.Author('newguy')
  Given -> @authorData = [
    {'url':'/post1','author':{'name':'jturnbull'}},
    {'url':'/post2','author':{'name':'cdmwebs'}},
    {'url':'/post3','author':{'name':'jturnbull'}},
  ]
  And -> @postCollection = new blogRanking.PostCollection(@authorData)
  And -> spyOn(blogRanking.AuthorCollection,'knownAuthorNames').andReturn(['newguy'])
  describe ".posts", ->
    Then -> expect(@postCollection.posts).toEqual([
      new blogRanking.Post('/post1',@author1),
      new blogRanking.Post('/post2',@author2),
      new blogRanking.Post('/post3',@author1),
    ])
  describe ".authors",->
    Then -> expect(@postCollection.authors()).toEqual([
      @author1,
      @author2,
      @author4,
    ])
  describe ".findByAuthor",->
    Then -> expect(@postCollection.findByAuthor(@postCollection.authors()[0])).toEqual([
      new blogRanking.Post('/post1',@author1),
      new blogRanking.Post('/post3',@author1),
    ])
  describe ".applyVisits", ->
    Given -> @data = [
      ['/post1',3],
      ['/post2',5],
    ]
    When -> @postCollection.applyVisits(@data)
    describe "merges visit data into post", ->
      Then -> expect(@postCollection.posts).toEqual([
        {'url':'/post1','author':@author1,'visits':3},
        {'url':'/post2','author':@author2,'visits':5},
        {'url':'/post3','author':@author1},
      ])
    describe "can be sorted by visit desc", ->
      Then -> expect(@postCollection.byVisits()).toEqual([
        {'url':'/post2','author':@author2,'visits':5},
        {'url':'/post1','author':@author1,'visits':3},
      ])
    describe "creates a post with visit data where no author has been set", ->
      Given -> @data =
        [['/post1',3],
         ['/post2',5],
         ['/post4',6]]
      When -> @postCollection.applyVisits(@data)
      Then -> expect(@postCollection.posts).toEqual(
        [{'url':'/post1','author':@author1,'visits':3},
         {'url':'/post2','author':@author2,'visits':5},
         {'url':'/post3','author':@author1},
         {'url':'/post4','author':@author3,'visits':6}])
  describe ".applyTimeOnSite", ->
      Given -> @data =
        [['/post1','169.0'],
         ['/post2','1379.0']]
      When -> @postCollection.applyTimeOnSite(@data)
      describe "merges data into post", ->
        Then -> expect(@postCollection.posts).toEqual([
          {'url':'/post1','author':@author1,'timeOnSite':169},
          {'url':'/post2','author':@author2,'timeOnSite':1379},
          {'url':'/post3','author':@author1},
        ])
      describe "can be sorted by data desc", ->
        Then -> expect(@postCollection.byTimeOnSite()).toEqual([
          {'url':'/post2','author':@author2,'timeOnSite':1379},
          {'url':'/post1','author':@author1,'timeOnSite':169},
        ])

