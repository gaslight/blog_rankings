describe "AuthorCollection", ->
  describe ".byTotalVisits", ->
    describe "sorts authors by total visits", ->
      Given -> @author1 = new blogRanking.Author('jturnbull')
      And   -> @author2 = new blogRanking.Author('cdmwebs')

      And   -> @post1 = new blogRanking.Post('/post1',@author1)
      And   -> @post2 = new blogRanking.Post('/post2',@author1)
      And   -> @post3 = new blogRanking.Post('/post3',@author2)
      And   -> @post4 = new blogRanking.Post('/post4',@author2)
      When  -> @post1.visits = 1 
      And   -> @post2.visits = 2 
      And   -> @post3.visits = 3 
      And   -> @post4.visits = 5 
      And   -> @authorCollection = new blogRanking.AuthorCollection([@post1,@post2,@post3,@post4])
      Then  -> expect(@authorCollection.byTotalVisits()).toEqual([@author2,@author1])
