describe "AuthorCollection", ->
  Given -> @authorData = [
    {'url':'/post1','author':{'name':'jturnbull'}},
    {'url':'/post2','author':{'name':'cdmwebs'}},
    {'url':'/post3','author':{'name':'cdmwebs'}},
    {'url':'/post4','author':{'name':'jturnbull'}},
  ]
  describe ".findOrCreateByName", ->
    When -> @postCollection = new blogRanking.PostCollection(@authorData)
    And  -> @authorCollection = new blogRanking.AuthorCollection(@postCollection)
    describe "when author exists", ->
      When -> @author = @authorCollection.findOrCreateByName('jturnbull')
      Then -> expect(@author).toEqual(new blogRanking.Author('jturnbull'))
      And  -> expect(@authorCollection.all().length).toEqual(2)
  describe ".all", ->
    When -> @postCollection = new blogRanking.PostCollection(@authorData)
    And  -> @authorCollection = new blogRanking.AuthorCollection(@postCollection)
    Then -> expect(@authorCollection.all()).toEqual([
      new blogRanking.Author('jturnbull'),
      new blogRanking.Author('cdmwebs'),
    ])
  describe ".byTotalVisits", ->
    describe "sorts authors by total visits", ->
      Given -> @visitData = [
        ['/post1',3],
        ['/post2',5],
        ['/post3',7],
        ['/post4',4],
      ]
      And   -> @postCollection = new blogRanking.PostCollection(@authorData)
      When  -> @postCollection.applyVisits(@visitData) 
      And   -> @authorCollection = new blogRanking.AuthorCollection(@postCollection)
      Then  -> expect(@authorCollection.byTotalVisits()).toEqual([new blogRanking.Author('cdmwebs'),new blogRanking.Author('jturnbull')])
