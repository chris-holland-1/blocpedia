class ChargesController < ApplicationController
  before_action :require_sign_in

  def new
    @stripe_btn_data = {
        key: Rails.configuration.stripe[:publishable_key].to_s,
        description: "Blocpedia Membership - #{current_user.email}",
        amount: @amount
    }
  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = StripeTool.create_customer(email: params[:stripeEmail],
                                          stripe_token: params[:stripeToken])

    # Where the real magic happens
    charge = StripeTool.create_charge(customer_id: customer.id,
                                      amount: @amount,
                                      description: 'Rails Stripe customer')

    current_user.update_attribute(:role, 'premium')

    if current_user.save!
      flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
      redirect_to user_path(current_user) # or wherever
    end

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  private

  def amount_to_be_charged
    @amount = 1500
  end
end
