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
    unless $scope.startDate && $scope.endDate           
      $scope.startDate = $("#startDatePicker").val()           
      $scope.endDate = $("#endDatePicker").val()

    gapi.client.load 'analytics', 'v3', -> 
      request = gapi.client.analytics.data.ga.get({
        'ids': 'ga:51266672',
        'dimensions' : 'ga:pagepath',
        'start-date': $scope.startDate,
        'end-date': $scope.endDate,
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

blogRanking.directive 'datepicker', -> 
  (scope, element, attrs) ->
    element.fdatepicker({
      format: 'yyyy-mm-dd'
    }).on 'changeDate', ->
      model = $(this).attr('ng-model')
      scope[model] = $(this).val()
