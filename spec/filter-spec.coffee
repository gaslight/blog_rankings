describe "Filter", ->
  describe ".constructor", ->
    describe "defaults to last full week Mon-Sun", -> 
      describe "when today is mid-week", ->
        Given -> Date.today = -> new Date("4/18/2013")
        When -> @filter = new blogRanking.Filter
        Then -> expect(@filter.startDate).toEqual("2013-04-08")
        And  -> expect(@filter.endDate).toEqual("2013-04-14")
      describe "when today is Monday", ->
        Given -> Date.today = -> new Date("4/15/2013")
        When -> @filter = new blogRanking.Filter
        Then -> expect(@filter.startDate).toEqual("2013-04-08")
        And  -> expect(@filter.endDate).toEqual("2013-04-14")
      describe "when today is Sunday", ->
        Given -> Date.today = -> new Date("4/14/2013")
        When -> @filter = new blogRanking.Filter
        Then -> expect(@filter.startDate).toEqual("2013-04-08")
        And  -> expect(@filter.endDate).toEqual("2013-04-14")
