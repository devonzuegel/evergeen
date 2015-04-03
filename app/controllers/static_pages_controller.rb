class StaticPagesController < ApplicationController

  def home
    at_home = true
    if logged_in?
      @user = User.find(current_user.id)
      @new_transaction = Transaction.new
    else
      @user = User.new
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end

end
