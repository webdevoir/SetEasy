class ProjectsController < ApplicationController
  def index
    if current_user.role == "Admin"
  	 @projects = Project.all
    else
      @projects = current_user.projects
      @projects = @projects.order(:updated_at).reverse_order
    end
  end

  def show
  	@project = Project.find(params[:id])
  end

  def new
  	@project = Project.new
       respond_to do |format|
      format.html
      format.js
    end

  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    @project.project_users.new(user: current_user, role: "Owner")

     if @project.save
        redirect_to projects_path, notice: "Projects Submitted successfully!"
      else
        flash[:error] = @project.errors.full_messages.to_sentence
        render :new, notice: "Project could not be created!"
      end
  end

  def edit
  	@project = Project.find(params[:id])
       respond_to do |format|
      format.html
      format.js
    end

  end

   def update
   	@project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to projects_path, notice: "Project updated successfully"
    else
      flash[:error] = "#{@project.errors.count} errors prevented certificate from being updated."
      render :edit
    end

  end

  def destroy
  	@project = Project.find(params[:id])
  	@project.destroy
  	 redirect_to projects_path, notice: "#{@project.id} was deleted successfully!"
  end

  def project_events
    @project = Project.find(params[:project_id])
    @events = @project.events
    # if @events.length > 1
      @events = @events.order(:start).page(params[:page]).per(10) 
    # end
  end

      protected

      def project_params
        params.require(:project).permit(:id, :name, :budget, :user_id
)
      end
end
