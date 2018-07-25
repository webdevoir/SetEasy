class EmailListsController < ApplicationController
	before_action :set_email, only: [:edit, :update, :destroy]
  def index
  	@emails = EmailList.all
  	@emails = @emails.order(:updated_at).reverse_order.page(params[:page]).per(15) 
  end

  def new
  	@email = EmailList.new
  end

   def create
    @email = EmailList.new(email_params)

     if @email.save
        redirect_to root_path, notice: "Thanks!  We'll keep you in the loop!"
      else
        logger.info @email.errors.full_messages.to_sentence
        render :new, notice: "Email could not be saved!"
      end
  end

   def update
      if @email.update_attributes(email_params)
        redirect_to root_path, notice: "Updated successfully!"

      else
        logger.info @email.errors.full_messages.to_sentence
        render :edit, notice: "Email could not be updated!"
      end
  end

  def destroy
  	@email.destroy
  	 redirect_to emails_path, notice: "#{@email.id} was deleted successfully!"
  end



  def edit
  end

  private

  def set_email
      @email = EmailList.find(params[:id])
  end

  def email_params
       params.require(:email_list).permit(:name, :email)
    end    
end