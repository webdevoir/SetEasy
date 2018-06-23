class Admin::UsersController < Admin::BaseAdminController
  def index
        @users = User.all
        @users = @users.order(:updated_at).reverse_order.page(params[:page]).per(15) 
    end

    def new
      @user = User.new
    end

    def edit
      @user  = User.find(params[:id])
    end

    def create
      @user = User.new(user_params)
      @user.email = @user.email.downcase.presence

      if @user.save
        redirect_to admin_users_path, notice: "User Created successfully!"
      else
        flash[:error] = @user.errors.full_messages.to_sentence
        render :new, notice: "User could not be created!"
      end
    end

    def update
      @user  = User.find(params[:id])
      @user.email = @user.email.downcase.presence
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      if @user.update_attributes(user_params)
        redirect_to admin_users_path, notice: "Updated successfully!"

      else
        flash[:error] = @user.errors.full_messages.to_sentence
        redirect_to admin_users_path
      end
    end

    def destroy
      @user  = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: "#{@user.id} was deleted successfully!"
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :employer_id)
  end
end