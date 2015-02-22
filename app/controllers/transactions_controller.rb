class TransactionsController < ApplicationController
	before_action :logged_in_user
	
  def deposit
  	@new_transaction = Transaction.new
  end


  def withdraw
  end

  def create
  	form_params = transaction_params
  	puts form_params[:amount]
  	form_params[:amount] = Monetize.parse(form_params[:amount]).fractional
  	puts form_params[:amount]
  	form_params[:user_id] = current_user[:id]
    @new_transaction = Transaction.new(form_params)
    
    amount_human_readable = Money.new(form_params[:amount], 'USD').format

    ap @new_transaction.amount
    ap amount_human_readable

    if @new_transaction.save
      # Indicate to user that they must activate their account through their
      # email before they may proceed.
      flash[:info] = "You just deposited #{amount_human_readable}!"
      redirect_to root_url
    else
    	@new_transaction.amount = amount_human_readable
	    render 'deposit'
    end
  end


  private  # ------------------------------------------------------------

    def transaction_params
      params.require(:transaction).permit(:description, 
      																		:amount, 
      																		:user_id)
    end


end
