class Transaction < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
	validates :amount, presence: true, numericality: {
		only_integer: true,
		greater_than_or_equal_to: 50
	}
end