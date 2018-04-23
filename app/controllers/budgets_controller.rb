class BudgetsController < ApplicationController
  def index
  	@budgets = Budget.all
  end

  def show
  	@budget = Budget.find(params[:id])
  end

  def new
  	@budget = Budget.new
    (1..4).each do |n|
      ans =  @budget.budget_items.build
    end
  end

  def create
    @budget = Budget.new(budget_params)

     if @budget.save
        redirect_to budgets_path, notice: "Budgets Submitted successfully!"
      else
        flash[:error] = @budget.errors.full_messages.to_sentence
        render :new, notice: "Budget could not be created!"
      end
  end

  def edit
  	@budget = Budget.find(params[:id])
  end

   def update
   	@budget = Budget.find(params[:id])
    if @budget.update_attributes(budget_params)
      redirect_to budgets_path, notice: "Budget updated successfully"
    else
      flash[:error] = "#{@budget.errors.count} errors prevented certificate from being updated."
      render :edit
    end

  end

  def destroy
  	@budget = Budget.find(params[:id])
  	@budget.destroy
  	 redirect_to budgets_path, notice: "#{@budget.id} was deleted successfully!"
  end

 protected


  def budget_params
      params.require(:budget).permit(:location_id, budget_items_attributes: [:id, :_destroy, :item, :price, :rental])
    end
end
