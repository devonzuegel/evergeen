class AddStripeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripeID, :string
  end
end
