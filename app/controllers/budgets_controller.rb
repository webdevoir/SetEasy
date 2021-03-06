class BudgetsController < ApplicationController
  include ApplicationHelper
  before_action :redirect_cancel, only: [:update]

  def index
    @project = current_project
    @budgets = @project.budgets
  end

  def show
  	@budget = Budget.find(params[:id])
  end

  def new
  	@budget = Budget.new
    @project = current_project
    (1..4).each do |n|
      ans =  @budget.budget_items.build
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @budget = Budget.new(budget_params)
     @project = Project.find_by(id: current_user.current_project)
     @budget.project_id = @project.id
    # @budget.user_id = current_user.id

     if @budget.save
        redirect_to edit_budget_path(@budget), notice: "Budgets Submitted successfully!"
      else
        flash[:error] = @budget.errors.full_messages.to_sentence
        render :new, notice: "Budget could not be created!"
      end
  end

  def edit
  	@budget = Budget.find(params[:id])
    @project = current_project
     respond_to do |format|
      format.html
      format.js
    end
  end

  def pdfs
    @project = current_project
    @budgets = @project.budgets
    html = render_to_string(:action => "index", :layout => false)

    @budgets.each do |n|
      # path = Rails.root.join("budgets/", "#{n.id}")
      # path = "#{budget_url(n)}"
      path = budget_path(n)

      html << render_to_string(:action => "show", :layout => false, :locals => {:@budget => n})
    end  


  
     css =  "#{Rails.public_path}/assets/application.css"

    pdf = PDFKit.new(html, :page_size => 'Letter')
    pdf.stylesheets << css

    send_data pdf.to_pdf, filename: "#{Date.today}-#{@project.name}-budget.pdf"
  end

   def update
   	@budget = Budget.find(params[:id])
    if @budget.update_attributes(budget_params)
      redirect_to budget_path(@budget), notice: "Budget updated successfully"
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

  def redirect_cancel
      @budget = Budget.find(params[:id])
      redirect_to budget_path(@budget), notice: "Your changes were not saved." if params[:cancel]
    end

  def budget_params
      params.require(:budget).permit(:location_id, :name, :budgeted, budget_items_attributes: [:id, :_destroy, :item, :price, :rent_status, :budgeted, :payment, :reference, :crew_id])
    end
end
