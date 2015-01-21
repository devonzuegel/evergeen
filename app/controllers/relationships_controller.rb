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
    current_user.follow(@user)
    respond_to do |format|
      ##
      # Only one of the following lines gets executed. (In this sense,
      # respond_to is like an if-then-else statement.) This causes the
      # actions to "degrade gracefully", which means that they work fine
      # in browsers that have JavaScript disabled.
      format.html { redirect_to(@user) }
      format.js
    end
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      # Same "degrade gracefully" behavior as in 'create' fn.
      format.html { redirect_to @user }
      format.js
    end
  end
end
