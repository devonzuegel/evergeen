class Account < ActiveRecord::Base

	attr_accessor :balance
	belongs_to :user

  def withdraw(amount)
  end


  def deposit(amount)
  end


  def self.transfer(args = {})
    from_account = args.fetch(:from)
    to_account = args.fetch(:to)
    amount = args.fetch(:amount)

    from_account.withdraw(amount)
    to_account.deposit(amount)
  end

end