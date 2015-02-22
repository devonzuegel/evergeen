require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

	def setup
		@user = users(:michael)
		@transaction = @user.transactions.build(
			amount: 100,
			description: 'Test transaction',
			charged: false,
			user_id: @user.id
		)
	end


	test 'should be valid' do
		assert @transaction.valid?
	end


	# Tests the validation that the user_id is present.
	test 'user id should be present' do
		@transaction.user_id = nil
		assert_not @transaction.valid?
	end

  test "amount should be present " do
    @transaction.amount = nil
    assert_not @transaction.valid?
  end


  test "amount should be at least 50 " do
    @transaction.amount = 2
    assert_not @transaction.valid?
  end


  test "order should be most recent first" do
    assert_equal Transaction.first, transactions(:most_recent)
  end


  test "associated transactions should be destroyed" do
    @user.save

    # Create a second transaction associated with @user.
    @user.transactions.create!(
			amount: 100,
			description: 'Test transaction',
			charged: false,
			user_id: @user.id
		)

    ##
		# In case tests change, create a dynamic variable that counts
		# the number of transactions associated with @user, which will
		# be destroyed at the same time as @user.
		num_to_remove = @user.transactions.count
    assert_difference 'Transaction.count', -num_to_remove do
      @user.destroy
    end
  end

end
