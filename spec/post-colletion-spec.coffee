describe "PostCollection", ->
  Given -> @author1 = new blogRanking.Author('jturnbull')
  Given -> @author2 = new blogRanking.Author('cdmwebs')
  Given -> @author3 = new blogRanking.Author()
  Given -> @author4 = new blogRanking.Author('newguy')
  Given -> @authorData = [
    {'doc':{'_id':1,'_rev':1,'url':'/post1','author':'jturnbull'}},
    {'doc':{'_id':2,'_rev':1,'url':'/post2','author':'cdmwebs'}},
    {'doc':{'_id':3,'_rev':1,'url':'/post3','author':'jturnbull'}},
  ]
  And -> @postCollection = new blogRanking.PostCollection().initializePosts(@authorData)
  And -> spyOn(blogRanking.AuthorCollection,'knownAuthorNames').andReturn(['newguy'])
  describe ".posts", ->
    Then -> expect(@postCollection.posts).toEqual([
      new blogRanking.Post(1,1,'/post1',@author1),
      new blogRanking.Post(2,1,'/post2',@author2),
      new blogRanking.Post(3,1,'/post3',@author1),
    ])
  describe ".authors",->
    Then -> expect(@postCollection.authors()).toEqual([
      @author1,
      @author2,
      @author4,
    ])
  describe ".findByAuthor",->
    Then -> expect(@postCollection.findByAuthor(@postCollection.authors()[0])).toEqual([
      new blogRanking.Post(1,1,'/post1',@author1),
      new blogRanking.Post(3,1,'/post3',@author1),
    ])
  describe ".applyVisits", ->
    Given -> @data = [
      ['/post1',3],
      ['/post2',5],
    ]
    When -> @postCollection.applyVisits(@data)
    describe "merges visit data into post", ->
      Then -> expect(@postCollection.posts).toEqual([
        {'id':1,'rev':1,'url':'/post1','author':@author1,'visits':3},
        {'id':2,'rev':1,'url':'/post2','author':@author2,'visits':5},
        {'id':3,'rev':1,'url':'/post3','author':@author1},
      ])
    describe "can be sorted by visit desc", ->
      Then -> expect(@postCollection.byVisits()).toEqual([
        {'id':2,'rev':1,'url':'/post2','author':@author2,'visits':5},
        {'id':1,'rev':1,'url':'/post1','author':@author1,'visits':3},
      ])
    describe "creates a post with visit data where no author has been set", ->
      Given -> @data =
        [['/post1',3],
         ['/post2',5],
         ['/post4',6]]
      When -> @postCollection.applyVisits(@data)
      Then -> expect(@postCollection.posts).toEqual(
        [{'id':1,'rev':1,'url':'/post1','author':@author1,'visits':3},
         {'id':2,'rev':1,'url':'/post2','author':@author2,'visits':5},
         {'id':3,'rev':1,'url':'/post3','author':@author1},
         {'id':undefined,'rev':undefined,'url':'/post4','author':{"name":undefined},'visits':6}])
  describe ".applyTimeOnSite", ->
      Given -> @data =
        [['/post1','169.0'],
         ['/post2','1379.0']]
      When -> @postCollection.applyTimeOnSite(@data)
      describe "merges data into post", ->
        Then -> expect(@postCollection.posts).toEqual([
          {'id':1,'rev':1,'url':'/post1','author':@author1,'timeOnSite':169},
          {'id':2,'rev':1,'url':'/post2','author':@author2,'timeOnSite':1379},
          {'id':3,'rev':1,'url':'/post3','author':@author1},
        ])
      describe "can be sorted by data desc", ->
        Then -> expect(@postCollection.byTimeOnSite()).toEqual([
          {'id':2,'rev':1,'url':'/post2','author':@author2,'timeOnSite':1379},
          {'id':1,'rev':1,'url':'/post1','author':@author1,'timeOnSite':169},
        ])

