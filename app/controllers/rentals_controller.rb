class RentalsController < ApplicationController
  include ApplicationHelper

  def index
    @project = current_project
    if params[:location_id]
      @set = Location.find(params[:location_id])
      if params[:filter] == "rental_filter"
        @rentals = @set.rentals.joins(:budget_item).merge(BudgetItem.where(:rent_status => true))
      elsif params[:filter] == "purchased"
        @rentals = @set.rentals.joins(:budget_item).merge(BudgetItem.where(:rent_status => false))
      else
        @rentals = @set.rentals.joins(:budget_item).order('budget_items.rent_status')
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
    if params[:source_id]
      source = Source.find(params[:source_id])
      @rental.desc = source.name
      @rental.source = source.vendor
      @rental.price = source.price
      @rental.remote_image_url = source.image_url
      @source = source.id
    end
    @set = Location.find(params[:location_id])
    @item = BudgetItem.find(params[:item]) if params[:item]
    
  end

  def create
    @rental = Rental.new(rental_params)
    @project = current_project
    @rental.project_id = @project.id
    
    budget_price = params[:price] ? params[:price] : @rental.price
    rental_status = params[:rental]  ? params[:price] : @rental.rental_status
    desc = params[:desc]  ? params[:desc] : @rental.desc
    item = params[:item] ? params[:item] : @rental.item
    @item = BudgetItem.find(item) if item
    set = @rental.location_id ? @rental.location_id : @item.budget.location.id
    @rental.location_id = set

    logger.info "XXXXXXXXXXXXXXXXXXX  RENTAL PARAMS XXXXXXXXXXXXXXXXXXXXx"
    # logger.info desc
    # logger.info rental_status
    # logger.info budget_price
    logger.info "Item ----> #{item}"
    logger.info "Set ----> #{set}"



     if @rental.save
        if @rental.source_id
          source = Source.find(@rental.source_id)
          source.update!(rental_id: @rental.id)
        end
        #########
        unless item
          @budget = Budget.find_by(location_id: @rental.location)
          BudgetItem.create!(budget_id: @budget.id, item: desc, price: budget_price, rent_status: rental_status, rental_id: Rental.last.id)
        else 
          @item.update(rental_id: Rental.last.id)
        end

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
    @rental.desc = @rental.budget_item.item
    @rental.price = @rental.budget_item.price
    @rental.status = @rental.budget_item.rent_status
  end

   def update
   	@rental = Rental.find(params[:id])
    set = @rental.location_id
    desc = params[:rental][:desc] && params[:rental][:desc].length > 0  ? params[:rental][:desc] : @rental.budget_item.item
    @rental.desc = desc

    if @rental.update_attributes(rental_params)
          @budgetitem = BudgetItem.find_by(rental_id: @rental.id)
          if params[:rental][:desc] && params[:rental][:desc].length > 0  || params[:rental][:price] || params[:rental][:status]
            budget_price = params[:rental][:price] ? params[:rental][:price] : @budgetitem.price
            status = params[:rental][:status] ? params[:rental][:status] : @budgetitem.rent_status
            @budgetitem.update!(item: desc, price: budget_price, rent_status: status)
          end
      redirect_to location_rental_path(set, @rental), notice: "rental updated successfully"
    else
      logger.info @rental.errors.full_messages.to_sentence
      redirect_to location_rentals_path(set), alert: "rental could not be updated!"

    end

  end

  def pdfs
      @set = Location.find(params[:location_id])
      @project = current_project
      @rentals = @set.rentals.joins(:budget_item).order('budget_items.rent_status')


    html = render_to_string(:action => "index", :layout => false, :locals => {:@set => @set, :@project => @project, :@rentals => @rentals})


    css =  "#{Rails.public_path}/assets/application.css"

    pdf = PDFKit.new(html, :page_size => 'Letter')
    pdf.stylesheets << css


    send_data pdf.to_pdf, filename: "#{Date.today}-#{@project.name}-rentals.pdf"
  end

  def destroy
  	@rental = Rental.find(params[:id])
    set = @rental.location_id
  	@rental.destroy
  	 redirect_to location_rentals_path(set), notice: "#{@rental.id} was deleted successfully!"
  end

      protected

      def rental_params
        params.require(:rental).permit(:source_id, :remote_image_url, :id, :location_id, :image, :desc, :status, :source, :due_date, :pick_date, :price, :item)
      end
end