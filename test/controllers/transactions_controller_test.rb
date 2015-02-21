require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :deposit
    assert_response :success
  end

end
