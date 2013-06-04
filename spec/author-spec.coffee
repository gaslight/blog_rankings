describe "Author", ->
  describe ".totalVisits", ->
    Given -> @author = new blogRanking.Author('jturnbull')
    And   -> @post1 = new blogRanking.Post('/post1',@author)
    And   -> @post2 = new blogRanking.Post('/post2',@author)
    And   -> @post3 = new blogRanking.Post('/post3',@author)
    And   -> @author.posts = [@post1,@post2,@post3]
    describe "sums visits for an author's post", ->
      When  -> @post1.visits = 3 
      And   -> @post2.visits = 5 
      Then  -> expect(@author.totalVisits()).toEqual(8)
    describe ".avgTimeOnSite", ->
      describe "avgs timeOnSite for an author's post", ->
        When  -> @post1.timeOnSite = 3000 
        And   -> @post2.timeOnSite = 5000 
        Then  -> expect(@author.avgTimeOnSite()).toEqual(4000)
    describe ".totalPosts", ->
      describe "sums visits for an author's post", ->
        Then  -> expect(@author.totalPosts()).toEqual(3)
