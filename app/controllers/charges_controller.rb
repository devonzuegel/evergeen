class ChargesController < ApplicationController
  include ActionView::Helpers::NumberHelper
  layout 'application'

  def index
  end

  def new
    @amount = nil
    @user = User.find(current_user.id)
  end


  def create
    amount_in_cents = params[:amount]  # Amount in cents
    @user = User.find(current_user.id)  # Find user in the db

    ap params
    
    ##
    # If the user doesn't yet have a stripeID, create a new
    # customer and save the stripeID into the user's row.
    if @user.stripeID == nil
      # Create a new Stripe customer.
      new_customer = Stripe::Customer.create(
        :email => @user.email,
        :card  => params[:stripeToken]
      )
      # Save the stripeID into the user's row.
      @user.update_attribute(:stripeID, new_customer.id)
    end

    begin
      # Create the charge
      charge = Stripe::Charge.create(
        :customer    => @user.stripeID,
        :amount      => amount_in_cents,
        :description => @user.email + ' deposit',
        :currency    => 'usd'
      )
      amount = number_to_currency(amount_in_cents.to_f/100)
      flash[:success] = "You successfully deposited #{amount}!"
      redirect_to @user
    rescue => e
      flash[:danger] = e.message
      @amount = amount
      redirect_to '/charges/new'
    end

  end


  private  # ------------------------------------------------------------

    # Whitelists only :stripeID for editing through this controller.
    def user_params
      params.permit(:stripeID)
    end

end
