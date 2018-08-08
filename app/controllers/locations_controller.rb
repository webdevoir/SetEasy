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
     respond_to do |format|
      format.html
      format.js
    end

  end

  def create
    @location = Location.new(location_params)
    @project = current_project
    @location.project_id = @project.id

     if @location.save
        Budget.create(project_id: @project.id, location_id: @location.id)
        redirect_to locations_path, notice: "Locations Submitted successfully!"
      else
        flash[:error] = @location.errors.full_messages.to_sentence
        render :new, notice: "Location could not be created!"
      end
  end

  def edit
  	@location = Location.find(params[:id])
     respond_to do |format|
      format.html
      format.js
    end
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

  def pdfs

   @project = current_project
   @locations = @project.locations

    html = render_to_string(:action => "index", :layout => false, :locals => {:@locations => @locations, :@project => @project})
    
    css =  "#{Rails.public_path}/assets/application.css"

    pdf = PDFKit.new(html, :page_size => 'Letter')
    pdf.stylesheets << css
    # pdf.stylesheets << view_context.asset_path 'application.css'

    send_data pdf.to_pdf, filename: "#{Date.today}-#{@project.name}-locations.pdf"
  end

  def destroy
  	@location = Location.find(params[:id])
  	@location.destroy
  	 redirect_to locations_path, notice: "#{@location.id} was deleted successfully!"
  end

      protected

      def location_params
        params.require(:location).permit(:id, :name, :street, :postal, :city, :province, :interior, :number)
      end
end