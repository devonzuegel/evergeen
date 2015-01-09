require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase


  def setup
    @micropost = microposts(:orange)
  end


  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post(:create, micropost: { content: "Lorem ipsum" })
    end
    assert_redirected_to(login_url)
  end


  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete(:destroy, id: @micropost)
    end
    assert_redirected_to(login_url)
  end

  
  ##
  # Make sure one user can’t delete the microposts of a different user,
  # and we also check for the proper redirect.
  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete(:destroy, id: micropost)
    end
    assert_redirected_to(root_url)
  end


end