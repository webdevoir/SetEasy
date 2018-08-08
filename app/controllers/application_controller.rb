class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :authorize
    before_action :has_project?

    delegate :allow?, to: :current_permission
	helper_method :allow?

	def after_sign_in_path_for(resource)
		logger.info "#################  LOGGED IN ##########################"
		logger.info "#################  #{current_user.email} ##########################"
		logger.info "#################  #{current_user.current_project} ##########################"
		if current_user && current_user.current_project == nil && current_user.projects.length > 0
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

	def allow_test(user, controller, action)
		Permission.new(user).allow?(controller, action)
	end


  def authorize
  	  # if current_user && current_user.current_project == nil
  	  # 	redirect_to (new_project_path, notice: "You must select a project first")
	  if !current_permission.allow?(params[:controller], params[:action], current_resource)
	  	redirect_back( fallback_location: root_path, notice: "Not authorized.")
	  	# render html: "<script>alert('No users!')</script>".html_safe
	  	logger.info "#################  ACTION --> #{params[:action]} ##########################"
	    logger.info "#################  NOT AUTHORIZED ##########################"
	  end
	end

  def has_project?
	project_ctrls = %w[crews events locations pdfs rentals budgets]
	controller = params[:controller]
	if controller.in?(project_ctrls) && current_user && current_user.current_project == nil
	  redirect_to projects_path, notice: "You must create a project first"
	end
  end
end
