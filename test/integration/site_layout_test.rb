require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path, count: 2
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", support_path
    assert_select "a[href=?]", mission_path
  end

  test "new deposit form" do
  	get root_path
  	assert_select "form"
  end

end
