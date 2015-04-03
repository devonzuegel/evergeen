require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path, count: 2
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", support_path

    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", signup_path
  end

  test "signup form if not logged in" do
  	get root_path
  	assert_select "form#new_user"
  	assert_select "form#new_transaction", false
  end

  test "deposit form if logged in" do
    log_in_as(@user)
  	get root_path
  	assert_select "form#new_transaction"
  	assert_select "form#new_user", false
  end

end
