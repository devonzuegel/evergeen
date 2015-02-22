class TransactionsController < ApplicationController
	before_action :logged_in_user
	
  def deposit
  	@user = current_user
  	@new_transaction = Transaction.new
  end


  def withdraw
  end

  def create
    @new_transaction = Transaction.new(transaction_params)
    ap params
    if @new_transaction.save
      # Indicate to user that they must activate their account through their
      # email before they may proceed.
      flash[:info] = "Please check your email to activate your account."
      redirect_to(root_url)
    else
      render('deposit')
    end
  end


  private  # ------------------------------------------------------------

    # NOTE: In particular, 'admin' is not in the list of permitted
    # attributes. This is what prevents arbitrary users from granting
    # themselves administrative access to our application.
    def transaction_params
      params.require(:transaction).permit(:description, :amount)
    end

end
