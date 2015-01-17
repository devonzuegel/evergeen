class RelationshipsController < ApplicationController
	##
	# If an unlogged-in user were to hit either action
	# directly, current_user would be nil, and in both cases
	# the action’s second line would raise an exception,
	# resulting in an error but no harm to the application
	# or its data. It’s best not to rely on that, though.
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to(user)
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to(user)
  end
end
