blogRanking = angular.module('blogRanking',[])


#  config(($routeProvider) -> 
#    $routeProvider.
#      when('/', {controller: ListCtrl, templateUrl: 'list.html'}))

ListCtrl = ($scope) ->
  $scope.stats = '123'
  setTimeout( (->
      debugger
      $scope.stats = 'abc'
    ), 3000
  )

blogRanking.controller 'ListCtrl', ListCtrl

window.Stats = {
  visitTotals: '123'
}

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
