class UsersController < ApplicationController

  ##
  # Only authorized users may access \index, \edit, \update, \destroy,
  # \:id\following, & \:id\followers.
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

  # Restricts access to the 'destroy' action to admins.
  before_action :admin_user,     only: :destroy

  # Redirects users trying to edit another user’s profile.
  before_action :correct_user,   only: [:edit, :update]


  def index
    ##
    # User.paginate pulls the users out of the database one chunk at a
    # time (30 by default), based on the :page parameter.
    @users = User.paginate(page: params[:page])
  end


  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      # Deliver account activation email
      @user.send_activation_email

      # Indicate to user that they must activate their account through their
      # email before they may proceed.
      flash[:info] = "Please check your email to activate your account."
      redirect_to(root_url)
    else
      render('new')
    end
  end

  def edit
    @user = User.find(params[:id])
    p params
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  def connect_humanAPI
    @user = User.find(params[:id])
    p params
  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    ##
    # The usual Rails convention is to implicitly render the template
    # corresponding to an action, but for followers & following the
    # view we want is nearly identical, so we can just explicitly call
    # a shared view called 'show_follow'.
    render('show_follow')
  end


  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    ##
    # The usual Rails convention is to implicitly render the template
    # corresponding to an action, but for followers & following the
    # view we want is nearly identical, so we can just explicitly call
    # a shared view called 'show_follow'.
    render('show_follow')
  end


  private  # ------------------------------------------------------------

    # NOTE: In particular, 'admin' is not in the list of permitted
    # attributes. This is what prevents arbitrary users from granting
    # themselves administrative access to our application.
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


    ##### Before filters #####
    

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end


    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end