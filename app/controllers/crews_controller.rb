class CrewsController < ApplicationController
  include ApplicationHelper

  def index
  	# @crews = Crew.all
    @project = current_project
    @crews = @project.crews
    @crews = @crews.order(:updated_at).reverse_order

     @ddays = @crews.where("role LIKE ?", "%Dresser%")
     @dresser_days = 0
     @ddays.each do |crew|
      @dresser_days = @dresser_days + crew.events.where("start <= ?",  Date.today).count
    end
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

  def pdfs

    @project = current_project
    @crews = @project.crews
    @path = "#{Rails.public_path}/assets/SetLogo_trans.png"
    @ddays = @crews.where("role LIKE ?", "%Dresser%")
     @dresser_days = 0
     @ddays.each do |crew|
      @dresser_days = @dresser_days + crew.events.where("start <= ?",  Date.today).count
    end

    html = render_to_string(:action => "index", :layout => false, :locals => {:@path => @path, :@crews => @crews, :@project => @project, :@dresser_days => @dresser_days})
    
    css =  "#{Rails.public_path}/assets/application.css"

    pdf = PDFKit.new(html, :page_size => 'Letter')
    pdf.stylesheets << css
    # pdf.stylesheets << view_context.asset_path 'application.css'

    send_data pdf.to_pdf, filename: "#{Date.today}-#{@project.name}-crews.pdf"
  end

      protected

      def crew_params
        params.require(:crew).permit(:id, :role, :name, :phone, :email, :phone, :availability, :notes, :skills => []
)
      end
end
