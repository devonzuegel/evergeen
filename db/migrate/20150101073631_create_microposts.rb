class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps null: false
    end

    ##
    # We expect to retrieve all the microposts associated with a given
    # user id in reverse order of creation.
    ##
    # By including both the user_id and created_at columns as an array,
    # we arrange for Rails to create a multiple key index.
    add_index :microposts, [:user_id, :created_at]
  end
end