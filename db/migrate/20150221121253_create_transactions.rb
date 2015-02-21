class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :stripe_id
      t.text :description
      t.boolean :charged
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :transactions, :users
    add_index :transactions, [:user_id, :created_at]
  end
end
