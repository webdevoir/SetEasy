class MessagesController < ApplicationController
	skip_before_action :authenticate_user!
	def new
		@message = Message.new
	end

	def create
	    @message = Message.new message_params

	    if @message.valid?
	      MainMailer.contact_me(@message).deliver_now
	      # flash[:success] = "Message received, thanks!"
	      redirect_back( fallback_location: root_path, notice: "Message received, thanks!")
	    else
	      flash[:error] = "There was an error sending your message."
	      render :new
	    end
	  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end

end
