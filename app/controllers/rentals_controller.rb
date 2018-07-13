class RentalsController < ApplicationController
  include ApplicationHelper

  def index
    @project = current_project
    if params[:location_id]
      @set = Location.find(params[:location_id])
      if params[:filter] == "rental_filter"
        @rentals = @set.rentals.where(rental: true)
      elsif params[:filter] == "purchased"
        @rentals = @set.rentals.where(rental: false)
      else
        @rentals = @set.rentals
      end
    else
      @rentals = @project.rentals
    end
  end

  def show
  	@rental = Rental.find(params[:id])
    @set = Location.find(params[:location_id])
  end

  def sets
    @project = current_project
    @sets = @project.locations
  end

  def new
  	@rental = Rental.new
    @set = Location.find(params[:location_id])
    
  end

  def create
    @rental = Rental.new(rental_params)
    @project = current_project
    @rental.project_id = @project.id
    set = @rental.location_id
    budget_price = params[:price] ? params[:price] : 1500


     if @rental.save

        #########
          @budget = Budget.find_by(location_id: @rental.location)
          BudgetItem.create(budget_id: @budget.id, item: @rental.desc, price: budget_price, rental_id: Rental.last.id)

          # @rental.budget_item = @budget_item
          # @rental.save

        ########
        redirect_to location_rentals_path(set), notice: "rentals Submitted successfully!"
      else
        logger.info @rental.errors.full_messages.to_sentence
        redirect_to location_rentals_path(set), alert: "rental could not be created!"
        # render :new, notice: "rental could not be created!"
      end
  end

  def edit
  	@rental = Rental.find(params[:id])
    @set = Location.find(params[:location_id])
  end

   def update
   	@rental = Rental.find(params[:id])
    set = @rental.location_id
    if @rental.update_attributes(rental_params)
      redirect_to location_rental_path(set, @rental), notice: "rental updated successfully"
    else
      flash[:error] = "#{@rental.errors.count} errors prevented certificate from being updated."
      render :edit
    end

  end

  def destroy
  	@rental = Rental.find(params[:id])
    set = @rental.location_id
  	@rental.destroy
  	 redirect_to location_rentals_path(set), notice: "#{@rental.id} was deleted successfully!"
  end

      protected

      def rental_params
        params.require(:rental).permit(:id, :location_id, :image, :desc, :rental, :source, :due_date, :pick_date, :price)
      end
end