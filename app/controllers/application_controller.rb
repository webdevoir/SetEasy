class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    # before_action :authenticate_user!
    before_action :authorize

    delegate :allow?, to: :current_permission
	helper_method :allow?

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
