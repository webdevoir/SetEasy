class CrewsController < ApplicationController
  def index
  	@crews = Crew.all
    @crews = @crews.order(:updated_at).reverse_order
  end

  def show
  	@crew = Crew.find(params[:id])
  end

  def new
  	@crew = Crew.new
  end

  def create
    @crew = Crew.new(crew_params)

     if @crew.save
        redirect_to crews_path, notice: "Crews Submitted successfully!"
      else
        flash[:error] = @crew.errors.full_messages.to_sentence
        render :new, notice: "Crew could not be created!"
      end
  end

  def edit
  	@crew = Crew.find(params[:id])
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
        params.require(:crew).permit(:id, :role, :name, :phone, :email, :phone, :availability, :skills, :notes
)
      end
end
