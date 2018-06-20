class SubscriptionsController < ApplicationController
  def new
  	  user = User.find_by(id: current_user.id)
  	  plan = Plan.find(params[:plan_id])
      @subscription = plan.subscriptions.build
  	  logger.info "$$$$$$$$$$$$$$$$  #{user.id} $$$$$$$$$$$$$$$$$$$$$$$"
	  # @subscription = Subscription.new
	  @subscription.user_id = current_user.id
	  # if params[:PayerID]
	  #   @subscription.paypal_customer_token = params[:PayerID]
	  #   @subscription.paypal_payment_token = params[:token]
	  #   @subscription.paypal_email = PayPal::Recurring.new(token: params[:token]).checkout_details.email
	  # end
  end

  def create
  	@subscription = Subscription.new(subscription_params)
  	@subscription.user_id = current_user.id
  	# @subscription.expiry = DateTime.now + 1.year
  	if @subscription.save_with_payment
  		redirect_to @subscription, notice: "thanks for subscribing"

  	else
  		logger.info "$$$$$$$$$$$$$$$$  #{@subscription.errors.full_messages.to_sentence} $$$$$$$$$$$$$$$$$$$$$$$"
  		render :new
  	end
  end

  def show
  	@subscription  = Subscription.find(params[:id])
  	@user = User.find_by(id: @subscription.user_id)
  end

 #  def paypal_checkout
	#   user = User.find_by(id: current_user.id)
	# #   subscription = user.subscriptions.build
	# #   redirect_to subscription.paypal.checkout_url(
	# #     return_url: new_subscription_url(:plan_id => plan.id),
	# #     cancel_url: root_url
	# #   )
	# # end
	# ppr = PayPal::Recurring.new(
	# 		return_url: new_subscription_url(user_id: current_user.id),
	# 		cancel_url: root_url,
	# 		description: "test",
	# 		amount: 20,
	# 		currency: "USD"
	# 	)
	# response = ppr.checkout
	# if response.valid?
	# 	redirect_to response.checkout_url
	# else
	# 	raise response.errors.inspect
	# end
 #  end

  private

  def subscription_params
    params.require(:subscription).permit(:stripe_card_token, :plan_id)
  end
end
