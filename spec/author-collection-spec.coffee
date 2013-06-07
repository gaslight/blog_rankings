describe "AuthorCollection", ->
  Given -> @authorData = [
    {'url':'/post1','author':{'name':'jturnbull'}},
    {'url':'/post2','author':{'name':'cdmwebs'}},
    {'url':'/post3','author':{'name':'cdmwebs'}},
    {'url':'/post4','author':{'name':'jturnbull'}},
  ]
  And -> @postCollection = new blogRanking.PostCollection(@authorData)
  And -> @authorCollection = new blogRanking.AuthorCollection(@postCollection)
  And -> spyOn(blogRanking.AuthorCollection,'knownAuthorNames').andReturn(['newguy'])
  describe ".findOrCreateByName", ->
    When -> @author = @authorCollection.findOrCreateByName('jturnbull')
    Then -> expect(@author).toBe(@postCollection.authors()[0])
  describe ".all", ->
    When -> @authorCollection.knownAuthorNames = ['newguy']
    Then -> expect(@authorCollection.all()).toEqual([
      new blogRanking.Author('jturnbull'),
      new blogRanking.Author('cdmwebs'),
      new blogRanking.Author('newguy'),
    ])
  describe "byTotalVisits", ->
    describe "sorts authors by total visits", ->
      Given -> @visitData = [
        ['/post1',3],
        ['/post2',5],
        ['/post3',7],
        ['/post4',4],
      ]
      When -> @postCollection.applyVisits(@visitData)
      Then -> expect(@authorCollection.byTotalVisits()).toEqual([new blogRanking.Author('cdmwebs'),new blogRanking.Author('jturnbull')])
