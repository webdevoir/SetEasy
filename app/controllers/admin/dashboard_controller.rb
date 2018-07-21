class Admin::DashboardController < Admin::BaseAdminController
	def landing
    	@users = User.all
    	@users = @users.order(:updated_at).reverse_order.page(params[:page]).per(15)
  	end

  	def download
    	
  	end
end
