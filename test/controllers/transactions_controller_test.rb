require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase

  def setup
    @transaction = transactions(:most_recent)
  end


  test "should redirect deposit when not logged in" do
    assert_no_difference 'Transaction.count' do
      post(:deposit, transaction: @transaction)
    end
    assert_redirected_to(login_url)
  end


  test "should redirect when not logged in" do
    assert_no_difference 'Transaction.count' do
      post(:withdraw, transaction: @transaction)
    end
    assert_redirected_to(login_url)
  end

  
  test "should get deposit & withdraw when logged in" do
    log_in_as(users(:michael))

    get :deposit
    assert_response :success

    get :withdraw
    assert_response :success
  end


end
