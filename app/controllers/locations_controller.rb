class LocationsController < ApplicationController
  include ApplicationHelper

  def index
  	# @locations = Location.all
    @project = current_project
    @locations = @project.locations
  end

  def show
  	@location = Location.find(params[:id])
  end

  def new
  	@location = Location.new
  end

  def create
    @location = Location.new(location_params)

     if @location.save
        redirect_to locations_path, notice: "Locations Submitted successfully!"
      else
        flash[:error] = @location.errors.full_messages.to_sentence
        render :new, notice: "Location could not be created!"
      end
  end

  def edit
  	@location = Location.find(params[:id])
  end

   def update
   	@location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      redirect_to locations_path, notice: "Location updated successfully"
    else
      flash[:error] = "#{@location.errors.count} errors prevented certificate from being updated."
      render :edit
    end

  end

  def destroy
  	@location = Location.find(params[:id])
  	@location.destroy
  	 redirect_to locations_path, notice: "#{@location.id} was deleted successfully!"
  end

      protected

      def location_params
        params.require(:location).permit(:id, :name, :street, :postal, :city, :province, :interior)
      end
end