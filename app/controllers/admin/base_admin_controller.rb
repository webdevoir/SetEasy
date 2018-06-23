class Admin::BaseAdminController < ActionController::Base
	 # use an admin-specific layout instead of the main application layout
  layout "application" 

  # all child controllers will automatically enforce access to admins only
  before_action :require_admin
  def current_user
    @current_user ||= warden.authenticate(:scope => :user)
  end

  helper_method :current_user

  def require_admin
      redirect_back( fallback_location: root_path, notice: "You need to be an admin to access that page! #{current_user.role}") unless current_user && current_user.role == "Admin"
  end
end
