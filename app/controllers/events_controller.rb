class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.where(start: params[:start]..params[:end])
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit

  end

  def create
    @event = Event.new(event_params)
    case @event.title
      when "Prep"
        @event.color = 'blue'
      when "Dress"
        @event.color = '#cec400'
      when "Wrap"
        @event.color = 'orange'
      else
        @event.color = 'red'
    end
          
    @event.save
  end

  def update
    @event.update(event_params)
    case @event.title
      when "Prep"
        @event.color = 'blue'
      when "Dress"
        @event.color = '#cec400'
      when "Wrap"
        @event.color = 'orange'
      else
        @event.color = 'red'
    end
  end

  def destroy
    @event.destroy
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :date_range, :start, :end, :color, :location_id,{crew_ids: []})
    end
end
