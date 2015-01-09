class MicropostsController < ApplicationController

  before_action(:logged_in_user, only: [:create, :destroy])
  before_action(:correct_user,   only: :destroy)

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to(root_url)
    else
      @feed_items = []
      render('static_pages/home')
    end
  end


  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    ##
    # The 'request.referrer' method is closely related to the request.url
    # variable used in friendly forwarding. It is just the previous URL.
    # Microposts appear on both the Home page and on the user’s profile
    # page; by using 'request.referrer' we redirect back to the page
    # issuing the delete request in both cases. If the referring URL is
    # nil, the root_url is set as the default.
    redirect_to(request.referrer || root_url)
  end


  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    # Checks that current_user actually has a micropost with the given id
    def correct_user
      ##
      # Find the micropost through the association, which automatically
      # fails if a user tries to delete another user’s micropost.
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to(root_url) if @micropost.nil?
    end

end
