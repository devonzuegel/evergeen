class Transaction < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
	validates :amount, presence: true, numericality: {
		only_integer: true,
		greater_than_or_equal_to: 100
	}
end