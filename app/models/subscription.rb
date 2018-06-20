class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan


  
  # attr_accessor :stripe_card_token
  

  def save_with_payment
		if valid?
		  # if paypal_payment_token.present?
	   #      save!
	   #    else
	        save_with_stripe_payment
	      # end
		end
	end

	def save_with_stripe_payment
			Stripe.api_key = ENV['STRIPE_API_KEY']
			cost = self.plan.price

			Stripe::Charge.create(
			  :amount => cost.to_i*100,
			  :currency => "usd",
			  :source => stripe_card_token, # obtained with Stripe.js
			  :description => "Subscription for Seteasy.ca"
			)
			save!
	end

	 # rescue Stripe::InvalidRequestError => e
	 #    logger.error "Stripe error while creating customer: #{e.message}"
	 #    errors.add :base, "There was a problem with your credit card."
	 #    false
	 #  end
end
