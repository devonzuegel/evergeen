class AddPricePermalinkAndNameToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :price, :integer
    add_column :transactions, :permalink, :string
    add_column :transactions, :name, :string
  end
end
