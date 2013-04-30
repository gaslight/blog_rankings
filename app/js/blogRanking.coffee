window.blogRanking = angular.module('blogRanking',[])

#  config(($routeProvider) -> 
#    $routeProvider.
#      when('/', {controller: ListCtrl, templateUrl: 'list.html'}))

class blogRanking.Filter
  
  defaultStartDate: ->
    today = Date.today()
    if today.is().monday() || today.is().sunday()
      today.last().monday()
    else
      today.last().week().last().monday()

  defaultEndDate: ->
    today = Date.today()
    if today.is().sunday()
      today
    else
      today.last().sunday()
  
  constructor: ->
    @startDate = @defaultStartDate unless @startDate
    @endDate   = @defaultEndDate   unless @endDate

ListCtrl = ($scope) ->

  $scope.filter = new blogRanking.Filter

  $scope.updatePageVisits = -> 
    $scope.makeApiCall($scope.filter)

  $scope.makeApiCall = (filter) ->
    gapi.client.load 'analytics', 'v3', -> 
      request = gapi.client.analytics.data.ga.get({
        'ids': 'ga:51266672',
        'dimensions' : 'ga:pagepath',
        'start-date': filter.startDate,
        'end-date': filter.endDate,
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

  $scope.updatePageVisits();

blogRanking.controller 'ListCtrl', ListCtrl

blogRanking.directive 'datepicker', -> 
  (scope, element, attrs) ->
    
    element.fdatepicker({
      format: 'yyyy-mm-dd'
    }).on 'changeDate', ->
      # e.g. ng-model is "filter.endDate"
      attrPath = $(this).attr('ng-model')
      attrs = attrPath.split(".")
      scope[attrs[0]][attrs[1]] = $(this).val()
