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
        pageVisits = []
        for row in resp.rows
          pageVisit = {"page":row[0],"visits":row[1]}
          pageVisits.push pageVisit
        $scope.pageVisits = pageVisits
        $scope.$apply()


blogRanking.controller 'ListCtrl', ListCtrl
