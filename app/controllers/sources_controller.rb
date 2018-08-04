class SourcesController < ApplicationController
	  before_action :set_source, only: [:show, :edit, :update, :destroy]
	    include ApplicationHelper
  def index
  	@project = current_project
  	if params[:location_id]
      @set = Location.find(params[:location_id])
      @sources = @set.sources
    else
      @sources = @project.sources
    end
  end

  def new
  	@source = Source.new
    @set = Location.find(params[:location_id])
  end

  def create
  	@source = Source.new(source_params)
  	@set = Location.find(params[:location_id])
    @project = current_project
    @source.project_id = @project.id
    @source.location_id = @set.id
    

      if @source.save
        redirect_to location_sources_path(@set), notice: "Source Submitted successfully!"
      else
        logger.info @source.errors.full_messages.to_sentence
        redirect_to location_sources_path(@set), alert: "Source could not be created!"
      end

  end

  def update
    @project = current_project
    @set = Location.find(@source.location_id)

    if @source.update_attributes(source_params)

      redirect_to location_source_path(@set, @source), notice: "Source updated successfully"
    else
      logger.info @source.errors.full_messages.to_sentence
      redirect_to location_sources_path(@set), alert: "Source could not be updated!"

    end

  end

  def edit
    @set = Location.find(params[:location_id])
  end

  def sets
    @project = current_project
    @sets = @project.locations
  end

  def show
    @set = Location.find(params[:location_id])
  end
private

    def set_source
      @source = Source.find(params[:id])
    end

    def source_params
       params.require(:source).permit(:name, :image)
    end                                                                                                                                                                                     

end
