class LookbooksController < ApplicationController
	  before_action :set_lookbook, only: [:show, :edit, :update, :destroy]
	  include ApplicationHelper

  def index
  	@project = current_project
  	if params[:location_id]
      @set = Location.find(params[:location_id])
      @lookbooks = @set.lookbooks
    else
      @lookbooks = @project.lookbooks
    end
  end

  def new
  	@lookbook = Lookbook.new
    @set = Location.find(params[:location_id])
  end

  def create
  	@lookbook = Lookbook.new(lookbook_params)
  	@set = Location.find(params[:location_id])
    @project = current_project
    @lookbook.project_id = @project.id
    @lookbook.location_id = @set.id
    

      if @lookbook.save
        redirect_to location_lookbooks_path(@set), notice: "Lookbook Submitted successfully!"
      else
        logger.info @lookbook.errors.full_messages.to_sentence
        redirect_to location_lookbooks_path(@set), alert: "Lookbook could not be created!"
      end

  end

  def update
    @project = current_project
    @set = Location.find(@lookbook.location_id)

    if @lookbook.update_attributes(lookbook_params)

      redirect_to location_lookbook_path(@set, @lookbook), notice: "Lookbook updated successfully"
    else
      logger.info @lookbook.errors.full_messages.to_sentence
      redirect_to location_lookbooks_path(@set), alert: "Lookbook could not be updated!"

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

    def destroy
    set = @lookbook.location_id
    @lookbook.destroy
     redirect_to location_lookbooks_path(set), notice: "#{@lookbook.id} was deleted successfully!"
  end
private

    def set_lookbook
      @lookbook = Lookbook.find(params[:id])
    end

    def lookbook_params
       params.require(:lookbook).permit(:name, :image, :desc)
    end                                                                                                                                                                                     

end
