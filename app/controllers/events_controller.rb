class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  include ApplicationHelper

  def index
    @events = Event.where(start: params[:start]..params[:end])
  end

  def show
  end

  def new
    @event = Event.new
    @project = current_project
  end

  def edit
    @project = @event.project
  end

  def create
    @event = Event.new(event_params)
    @project = current_project
    @event.project_id = @project.id
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
          
    if @event.save
    else
      logger.info "#{@event.errors.full_messages.to_sentence}"
    end
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
