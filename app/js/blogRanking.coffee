blogRanking = angular.module('blogRanking',[])

#  config(($routeProvider) -> 
#    $routeProvider.
#      when('/', {controller: ListCtrl, templateUrl: 'list.html'}))

ListCtrl = ($scope) ->

  $scope.pageVisits = [
    {"page":"page A","visits":3},
    {"page":"page B","visits":5},
    {"page":"page C","visits":8},
  ]

  $scope.updatePageVisits = -> 
    $scope.pageVisits = [
      {"page":"page A","visits":$scope.pageVisits[0].visits + 1},
      {"page":"page B","visits":$scope.pageVisits[1].visits + 1},
      {"page":"page C","visits":$scope.pageVisits[2].visits + 1},
    ]

blogRanking.controller 'ListCtrl', ListCtrl

###
  constructor: ->
    @visitTotals = '123'
    @load()

  load: ->
    that = this
    gapi.client.load 'analytics', 'v3', -> 
      request = gapi.client.analytics.data.ga.get({
        'ids': 'ga:51266672',
        'dimensions' : 'ga:pagepath',
        'start-date': '2013-03-01',
        'end-date': '2013-03-15',
        'metrics': 'ga:visits',
        'sort': '-ga:visits',
      })

      request.execute (resp) ->
        debugger
        that.visitTotals = resp.totalsForAllResults["ga:visits"]
