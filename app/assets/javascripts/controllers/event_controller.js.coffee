class @EventController 
  constructor: (@$scope, $routeParams, calendarService) ->
    day = calendarService.day($routeParams.day)
    @$scope.day = day.public()
    @$scope.Add = () ->
       calendarService.addEvent $scope.event

EventController.$inject = ["$scope", "$routeParams", "calendarService"]

class @EventListController 
  constructor: (@$scope, $routeParams, calendarService) ->
    @$scope.day = calendarService.fetchDay($routeParams.day)

EventListController.$inject = ["$scope", "$routeParams", "calendarService"]    
    
class @EventModalController
	constructor: (@$scope, @$location, @calendarService, @eventService) ->
		@define_methods()

	define_methods: ->
		@$scope.setModel = @setModel

		@$scope.AddEvent = () =>
			@eventService.save({ name: @$scope.name, description: @$scope.description, date: @$scope.date }, (event) =>
				@calendarService.addEvent(event.date, { id: event.id, name: event.name, description: event.description, date: event.date })
			)
			
	setModel: (data) ->
		@$scope.$apply => 
			@$scope.name = data.name
			@$scope.description = data.description
			@$scope.date = data.date

EventModalController.$inject = ["$scope", "$location", "calendarService", "eventService"]

class @EventEditController
	constructor: (@$scope, @$location, @$routeParams, @calendarService, @eventService) ->
		@define_methods()

	define_methods: ->
		@eventService.get({ id: @$routeParams.id }, (event) =>
			@$scope.event_name = event.name
			@$scope.date = event.date
			@$scope.name = event.name
			@$scope.description = event.description
		)

		@$scope.UpdateEvent = () =>
			@eventService.update({ id: @$routeParams.id, name: @$scope.name, description: @$scope.description, date: @$scope.date })
			date = moment(@$scope.date)
			@$location.path "/calendar/month/#{date.month() + 1}/#{date.year()}"

		@$scope.DeleteEvent = () =>
			@eventService.delete(id: @$routeParams.id)
			date = moment(@$scope.date)
			@$location.path "/calendar/month/#{date.month() + 1}/#{date.year()}"

EventEditController.$inject = ["$scope", "$location", "$routeParams", "calendarService", "eventService"]