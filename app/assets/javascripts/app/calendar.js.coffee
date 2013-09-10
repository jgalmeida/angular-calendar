scheduler = angular.module "Scheduler", ["ngResource"], ["$routeProvider", ($routeProvider) ->
  $routeProvider.when(
      '/calendar/month/:month/:year/',
      controller: MonthController
      templateUrl: '/calendar/month.html')
    .when(
      '/calendar/:day/events',
      controller: EventListController 
      templateUrl: '/events/index.html')
    .when(
      '/calendar/events/:id',
      controller: EventEditController 
      templateUrl: '/events/edit.html')
    .otherwise( {redirectTo: "/calendar/month/#{moment().month() + 1 || 1}/#{moment().year()}" })
]