class @MonthController 
  constructor: (@$scope, @$location, @eventService, $routeParams, calendarService) ->
    calendarService.setup($routeParams.month, $routeParams.year)
    @calendar = calendarService
    @define_methods @calendar
    @load_events()
  
  load_events: () ->
    calendar = @calendar
    @eventService.between @calendar.first_day(), @calendar.last_day(), (events) ->
      _.each events, (event) ->
        calendar.addEvent moment(event.date).format("YYYY-MM-DD"), event

  define_methods: (calendar) ->
    @$scope.showEvents = (day) =>
      @$location.path "/calendar/#{day}/events"

    @$scope.editEvent = (event_id) =>
      @$location.path "/calendar/events/#{event_id}"
    
    @$scope.weeks = () =>
      @calendar.weeks()

    @$scope.month_name = moment("01/#{calendar.current_month()}/#{calendar.current_year()}",'dd/M/YYYY').format("MMMM")

    @$scope.previousMonth = () =>
      date = sum_months("months", -1)
      @$location.path "/calendar/month/#{date.months() + 1}/#{date.years()}/"

    @$scope.today = () =>
      current_month = moment().month()
      current_year  = moment().year()
      @$location.path "/calendar/month/#{current_month + 1}/#{current_year}/"

    @$scope.nextMonth = () =>
      date = sum_months("months", 1)
      @$location.path "/calendar/month/#{date.month() + 1}/#{date.years()}/"

    sum_months = (month_or_year, number) =>
      current_month = calendar.current_month() 
      current_year  = calendar.current_year()
      date = moment("01/#{current_month}/#{current_year}",'dd/M/YYYY').add(month_or_year, number)

MonthController.$inject = ["$scope", "$location", "eventService", "$routeParams", "calendarService"]