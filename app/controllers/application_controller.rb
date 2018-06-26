class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :authorize

    delegate :allow?, to: :current_permission
	helper_method :allow?

	def after_sign_in_path_for(resource)
		logger.info "#################  LOGGED IN ##########################"
		logger.info "#################  #{current_user.email} ##########################"
		logger.info "#################  #{current_user.current_project} ##########################"
		unless current_user.current_project
			project = current_user.projects.first.id
			current_user.update(current_project: project)
		end
		projects_path
	end

  	def current_permission
	  @current_permission ||= Permission.new(current_user)
	end

	def current_resource
	  nil
	end


  def authorize
	  if !current_permission.allow?(params[:controller], params[:action], current_resource)
	  	redirect_back( fallback_location: root_path, notice: "Not authorized.")
	    logger.info "#################  NOT AUTHORIZED ##########################"
	  end
	end
end
