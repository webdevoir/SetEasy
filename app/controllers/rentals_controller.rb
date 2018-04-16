class RentalsController < ApplicationController
    def index
  	@rentals = Rental.all
  end

  def show
  	@rental = Rental.find(params[:id])
  end

  def new
  	@rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)

     if @rental.save
        redirect_to rentals_path, notice: "rentals Submitted successfully!"
      else
        flash[:error] = @rental.errors.full_messages.to_sentence
        render :new, notice: "rental could not be created!"
      end
  end

  def edit
  	@rental = Rental.find(params[:id])
  end

   def update
   	@rental = Rental.find(params[:id])
    if @rental.update_attributes(rental_params)
      redirect_to rentals_path, notice: "rental updated successfully"
    else
      flash[:error] = "#{@rental.errors.count} errors prevented certificate from being updated."
      render :edit
    end

  end

  def destroy
  	@rental = Rental.find(params[:id])
  	@rental.destroy
  	 redirect_to rentals_path, notice: "#{@rental.id} was deleted successfully!"
  end

      protected

      def rental_params
        params.require(:rental).permit(:id, :image, :desc, :rental, :source, :due_date)
      end
end