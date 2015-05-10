require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  ##
  # Visit the user profile page and check for the page title and the
  # user’s name, Gravatar, transaction count, and paginated transactions.
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name

    # Checks for an img tag with class gravatar inside a top-level heading tag (h1).
    assert_select 'h1>img.gravatar'
    assert_match @user.transactions.count.to_s, response.body
    assert_select 'div.pagination'
    @user.transactions.paginate(page: 1).each do |t|
    	# 'response.body' contains the full HTML source of the page.
    	# Note: 'assert_match' is a much less specific assertion than
    	# assert_select; in particular, unlike assert_select, using
    	# assert_match in this context doesn’t require us to indicate
    	# which HTML tag we’re looking for.
      assert_match(number_to_currency(t.amount), response.body)
    end
  end
end
