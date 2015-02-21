require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

	def setup
		@user = users(:michael)
		@transaction = Transaction.new(
			amount: 42,
			stripe_id: nil,
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

end
