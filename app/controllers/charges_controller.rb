class ChargesController < ApplicationController
  layout 'application'

  def new
    @amount = 2222
  end


  def create
    # Amount in cents
    @amount = params[:amount]
    puts @amount

    # Find the user in the db
    @user = User.find(current_user.id)

    ##
    # If the user doesn't yet have a stripeID, create a new customer and
    # save the stripeID into the user's row.
    if @user.stripeID == nil
      ap params[:stripeID]

      # Create a new Stripe customer.
      new_customer = Stripe::Customer.create(
        :email => @user.email,
        :card  => params[:stripeToken]
      )

      # Save the stripeID into the user's row.
      @user.update_attribute(:stripeID, new_customer.id)
    end

    # Create the charge
    charge = Stripe::Charge.create(
      :customer    => @user.stripeID,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end


  private  # ------------------------------------------------------------

    # Whitelists only :stripeID for editing through this controller.
    def user_params
      params.permit(:stripeID)
    end

end
