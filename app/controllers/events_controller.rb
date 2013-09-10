class EventsController < ApplicationController
  respond_to :json

  #GET /events
  def index
    render json: Event.all
  end

  #POST /events
  def create
    event = Event.new(params[:event])
    event.save
    render json: event
  end

  #GET /events/DDMMYYY
  def date
    date =  Date.strptime(params[:date],"%Y-%m-%d")
    render json: Event.where(date: date)
  end

  # GET /events/from/:from/to/:to
  def between
    from  =  Date.strptime(params[:from], "%Y-%m-%d")
    to    =  Date.strptime(params[:to],   "%Y-%m-%d")
    events = Event.between from, to
    render json: events
  end

  def from
    from  =  Date.strptime(params[:from], "%Y-%m-%d")
    events = Event.gte from
    render json: events
  end

  def to
    to  =  Date.strptime(params[:to], "%Y-%m-%d")
    events = Event.lte to
    render json: events
  end

  #GET /events/:id
  def show
    event = Event.find params[:id]
    render json: event
  end

  #PUT /events/:id
  def update
    event = Event.find params[:id]
    event.update_attributes params[:event]
    render json: event
  end

  #DELETE /events/:id
  def destroy
    Event.find(params[:id]).destroy
    head 200
  end

end
