class ChargesController < ApplicationController
  before_action :require_sign_in

  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        # Rails.configuration.stripe[:publishable_key].to_s
        description: "Blocpedia Membership - #{current_user.email}",
        amount: @amount
    }
  end

  def create
    @user = current_user

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
    customer: customer.id,
    amount: @amount,
    description: "Upgrade to Premium Membership - #{current_user.email}",
    currency: 'usd'
  )

    current_user.update_attribute(:role, 'premium')

    if current_user.save!
      flash[:notice] = "Thanks for all the money, #{current_user.email}! ou can now create and edit private wikis."
      redirect_to root_path # or wherever
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

  def upgrade_user_role
    @user.role = 'premium'
  end
end
