class PlansController < ApplicationController
	before_action :set_plan, only: [:edit, :update, :destroy]

   def index
    @plans = Plan.order("price")
  end

  def manage
    @plans = Plan.order("price")
  end

  def new
  	@plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)

     if @plan.save
        redirect_to plans_path, notice: "Plan created successfully!"
      else
        flash[:error] = @plan.errors.full_messages.to_sentence
        render :new, notice: "Plan could not be created!"
      end
  end

  def edit
  end

   def update
      if @plan.update_attributes(plan_params)
        redirect_to plans_path, notice: "Updated successfully!"

      else
        flash[:error] = @plan.errors.full_messages.to_sentence
        render :edit, notice: "Plan could not be updated!"
      end
  end

  def destroy
  	@plan.destroy
  	 redirect_to plans_path, notice: "#{@plan.id} was deleted successfully!"
  end

   private

  def set_plan
      @plan = Plan.find(params[:id])
  end

  def plan_params
       params.require(:plan).permit(:price, :name)
    end    
end
