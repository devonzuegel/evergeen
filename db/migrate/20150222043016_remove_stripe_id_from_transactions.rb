class RemoveStripeIdFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :stripe_id, :string
  end
end
