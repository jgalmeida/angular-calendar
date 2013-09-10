app = angular.module("Scheduler")
app.factory "calendarService", () ->
    return new Manager


class Day
  @format="YYYY-MM-DD"
  constructor: (@date, @format="YYYY-MM-DD") ->
    @_id = moment(@date).format(@format)
    @events = []
    @moment_date = moment(@date)

  id: ()->
    @_id

  day_only: () ->
    @moment_date.format("DD")

  fdate: (format) ->
    format ?= @format
    @moment_date.format(format)

  add_event: (event) ->
    @events.push(event)

  to_json: () ->
    id: @id()
    date: @moment_date.format(@format)


class Week
  constructor: (week_of_year) ->
    @week_of_year = week_of_year
    @days = []
    @build_week(week_of_year)
    @build_index()
    @inspect()

  inspect: () ->
    console.log " ---------- WEEKS -----------"
    console.log "week day - #{@week_of_year}"
    console.log @days

  find: (date) ->
    @index[date]

  build_index: () ->
    @index = {}
    _.each @days, (day) =>
      @index[day.fdate()] = day

  build_week: () ->
    begin_of_week = moment().week(@week_of_year).startOf('week')
    for incr in [1..7]
      @days.push new Day(moment(begin_of_week).add('days',incr).toDate())

  getDay: (date) ->
    _date = date
    if date instanceof Date
      _date = moment(date).format(Day.format)
    _day = _.find @days, (day) ->
      day.fdate() == _date
    _day



class CalendarPage
  constructor: (month, year) ->
    @weeks = []
    begin = moment("01/#{month}/#{year}",'dd/M/YYYY').startOf('month').weeks()
    end   = moment("28/#{month}/#{year}",'dd/M/YYYY').endOf('month').weeks()
    @build_weeks([begin..end])

  first_week: () ->
    [first, last...] = @weeks
    first

  last_week: () ->
    [first, mid..., last] = @weeks
    last

  build_weeks: (week_range) ->
    _.each week_range, (week_day) =>
      @weeks.push new Week(week_day)

  day: (date) ->
    _day = null
    _.find @weeks, (week) ->
      _day = week.find date
    _day || Day.new()



class Manager
  setup: (month, year) ->
    @page = new CalendarPage(month, year)
    @month = month
    @year  = year

  fetchDay: (date) ->
    @page.day(date)

  addEvent: (date, event) ->
    day = @page.day(date)
    day.add_event(event)

  weeks: () ->
    console.log @page.weeks
    @page.weeks

  first_day: () ->
    week = @page.first_week()
    [first, mid..., last] = week.days
    last.fdate()

  last_day: () ->
    last_week = @page.last_week()
    [x1, xm..., last_day] = last_week.days
    last_day.fdate()

  current_month: () ->
    @month

   current_year: () ->
    @year



