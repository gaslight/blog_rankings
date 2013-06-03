window.blogRanking = angular.module('blogRanking',[])

#  config(($routeProvider) -> 
#    $routeProvider.
#      when('/', {controller: ListCtrl, templateUrl: 'list.html'}))

ListCtrl = ($scope, $http) ->

  $scope.filter = new blogRanking.Filter

  $scope.updatePage = -> 
    fetchPosts()

  fetchPosts = ->
    $http(
      url: "posts",
      method: "GET",
    ).success( 
      (data, status, headers, config) -> 
        postsCollection = new blogRanking.PostCollection(data)
        applyPostVisits(postsCollection,$scope.filter)
        #fetchPostEngagements($scope.filter)
    ).error( 
      (data, status, headers, config) -> 
        $scope.status = status
    ) 

  $scope.authors = ->
    postsWithAuthors = _.select($scope.posts, (post) -> post.author )
    _.collect(postsWithAuthors, (post) -> post.author)

  applyPostVisits = (postsCollection,filter) ->
    gapi.client.load 'analytics', 'v3', -> 
      request = prepareRequest(filter,{
        'metrics': 'ga:visits',
        'sort': '-ga:visits',
      })
      request.execute (response) ->
        postsCollection.applyVisits(response.rows)
        applyPostEngagements(postsCollection,$scope.filter)
        $scope.posts = postsCollection.posts
        debugger
        $scope.$apply()

  applyPostEngagements = (postsCollection,filter) ->
    gapi.client.load 'analytics', 'v3', -> 
      request = prepareRequest(filter,{
        'metrics': 'ga:avgTimeOnSite',
        'sort': '-ga:avgTimeOnSite',
      })
      request.execute (response) ->
        postsCollection.posts = $scope.posts
        postsCollection.applyTimeOnSite(response.rows)
        $scope.posts = postsCollection.posts
        debugger
        $scope.$apply()

  prepareRequest= (filter,params) ->
    standard_params = {
        'ids': 'ga:51266672',
        'dimensions' : 'ga:pagepath',
        'start-date': filter.startDate,
        'end-date': filter.endDate,
        'max-results': '10',
    }
    gapi.client.analytics.data.ga.get(jQuery.extend(standard_params,params))

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
