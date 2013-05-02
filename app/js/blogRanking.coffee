window.blogRanking = angular.module('blogRanking',[])

#  config(($routeProvider) -> 
#    $routeProvider.
#      when('/', {controller: ListCtrl, templateUrl: 'list.html'}))

class blogRanking.Filter
  
  dateFormat = "yyyy-MM-d"
  
  defaultStartDate: ->
    date = null
    today = Date.today()

    if today.is().monday() || today.is().sunday()
      date = today.last().monday()
    else
      date = today.last().week().last().monday()

    date.toString(dateFormat)

  defaultEndDate: ->
    date = null
    today = Date.today()

    if today.is().sunday()
      date = today
    else
      date = today.last().sunday()

    date.toString(dateFormat)
  
  constructor: ->
    @startDate = @defaultStartDate() unless @startDate
    @endDate   = @defaultEndDate()   unless @endDate

ListCtrl = ($scope) ->

  $scope.filter = new blogRanking.Filter

  $scope.updatePage = -> 
    makeVisitsCall($scope.filter)
    makeEngagmentCall($scope.filter)

  makeEngagmentCall = (filter) ->
    gapi.client.load 'analytics', 'v3', -> 
      request = prepareRequest(filter,{
        'metrics': 'ga:avgTimeOnSite',
        'sort': '-ga:avgTimeOnSite',
      })

      $scope.pageEngagements = []
      executeRequest(request,$scope.pageEngagements)

  makeVisitsCall = (filter) ->
    gapi.client.load 'analytics', 'v3', -> 
      request = prepareRequest(filter,{
        'metrics': 'ga:visits',
        'sort': '-ga:visits',
      })

      $scope.pageVisits = []
      executeRequest(request,$scope.pageVisits)

  prepareRequest= (filter,params) ->
    standard_params = {
        'ids': 'ga:51266672',
        'dimensions' : 'ga:pagepath',
        'start-date': filter.startDate,
        'end-date': filter.endDate,
        'max-results': '10',
    }
    gapi.client.analytics.data.ga.get(jQuery.extend(standard_params,params))

  executeRequest = (request,models) ->
    request.execute (resp) ->
      results = []
      for row in resp.rows
        result = {"page":row[0],"result":row[1]}
        models.push result
      $scope.$apply()

  $scope.updatePage();

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
