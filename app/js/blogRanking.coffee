window.blogRanking = angular.module('blogRanking',[])

#  config(($routeProvider) -> 
#    $routeProvider.
#      when('/', {controller: ListCtrl, templateUrl: 'list.html'}))

ListCtrl = ($scope, $http) ->

  $scope.filter = new blogRanking.Filter

  $scope.updatePage = -> 
    fetchPostAuthors()
    fetchVisits($scope.filter)
    fetchEngagements($scope.filter)

  fetchPostAuthors = ->
    $http(
      url: "post_authors",
      method: "GET",
    ).success( 
      (data, status, headers, config) -> 
        $scope.postAuthors = data
    ).error( 
      (data, status, headers, config) -> 
        $scope.status = status
    ) 

  $scope.authors = ->
    authors = []
    for post,author of $scope.postAuthors
      authors.push author
    authors

  $scope.authorAuthored = (author,page) ->
    $scope.postAuthors[page] == author

  fetchEngagements = (filter) ->
    gapi.client.load 'analytics', 'v3', -> 
      request = prepareRequest(filter,{
        'metrics': 'ga:avgTimeOnSite',
        'sort': '-ga:avgTimeOnSite',
      })

      $scope.pageEngagements = []
      executeRequest(request,$scope.pageEngagements,formatSecondsToMinutes)

  fetchVisits = (filter) ->
    gapi.client.load 'analytics', 'v3', -> 
      request = prepareRequest(filter,{
        'metrics': 'ga:visits',
        'sort': '-ga:visits',
      })

      $scope.pageVisits = []
      $scope.authorVisits = new blogRanking.VisitsPerAuthor($scope.pageVisits,$scope.postAuthors).results()
      executeRequest(request,$scope.pageVisits,formatNone)

  formatNone = (value) -> 
    value

  formatSecondsToMinutes = (value) -> 
    minutes = Math.floor(value / 60)
    seconds = Math.round(value % 60)
    minuteString = minutes.toString()
    secondString = if seconds < 10 then "0" + seconds.toString() else seconds.toString()
    minuteString + ":" + secondString 

  prepareRequest= (filter,params) ->
    standard_params = {
        'ids': 'ga:51266672',
        'dimensions' : 'ga:pagepath',
        'start-date': filter.startDate,
        'end-date': filter.endDate,
        'max-results': '10',
    }
    gapi.client.analytics.data.ga.get(jQuery.extend(standard_params,params))

  executeRequest = (request,models,formatter) ->
    request.execute (resp) ->
      results = []
      for row in resp.rows
        result = {"page":row[0],"result": formatter(row[1])}
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
