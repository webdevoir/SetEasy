class Projects::ProjectUsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_project

  	def create
	  @project_user = @project.project_users.new(project_user_params)
	  @project_user.project = @project
    # project_user.current_project = @project

	  if @project_user.save
	    redirect_to @project, notice: 'Invite Sent!'
	  else
	    redirect_to @project, alert: 'Invite could not be sent.'
	  end
	end


  def destroy
    @project_user = ProjectUser.find(params[:id])
    @project_user.destroy

     redirect_to project_path(@project_user.project), notice: "#{@project_user.id} was deleted successfully!"
  end

  private
    def set_project
      if current_user.role == "Admin"
        @project = Project.find(params[:project_id])
      else
        @project = current_user.projects.find(params[:project_id])
      end
    end

    def project_user_params
      params.require(:project_user).permit(:email, :role)
    end
end
