class CrewsController < ApplicationController
  include ApplicationHelper

  def index
  	# @crews = Crew.all
    @project = current_project
    @crews = @project.crews
    @crews = @crews.order(:updated_at).reverse_order
  end

  def show
  	@crew = Crew.find(params[:id])
  end

  def new
  	@crew = Crew.new
     respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @crew = Crew.new(crew_params)
    @project = current_project
    @crew.project_id = @project.id

     if @crew.save
        redirect_to crews_path, notice: "Crews Submitted successfully!"
      else
        flash[:error] = @crew.errors.full_messages.to_sentence
        render :new, notice: "Crew could not be created!"
      end
  end

  def edit
  	@crew = Crew.find(params[:id])
     respond_to do |format|
      format.html
      format.js
    end
  end

   def update
   	@crew = Crew.find(params[:id])
    if @crew.update_attributes(crew_params)
      redirect_to crews_path, notice: "Crew updated successfully"
    else
      flash[:error] = "#{@crew.errors.count} errors prevented certificate from being updated."
      render :edit
    end

  end

  def destroy
  	@crew = Crew.find(params[:id])
  	@crew.destroy
  	 redirect_to crews_path, notice: "#{@crew.id} was deleted successfully!"
  end

  def crew_events
    @crew = Crew.find(params[:crew_id])
    @events = @crew.events
    # if @events.length > 1
      @events = @events.order(:start).page(params[:page]).per(10) 
    # end
  end

      protected

      def crew_params
        params.require(:crew).permit(:id, :role, :name, :phone, :email, :phone, :availability, :notes, :skills => []
)
      end
end
