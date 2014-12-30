class SessionsController < ApplicationController

  def new
  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in(user)
        # Handling the submission of the “remember me” checkbox.
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # Redirects to stored location (or to the user's page)
        redirect_back_or(user)
      else
        flash[:warning] = "Account not activated. Check your email for the activation link."
        redirect_to(root_url)
      end
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render('new')
    end
  end


  def destroy
    log_out() if logged_in?
    redirect_to(root_url)
  end

end
