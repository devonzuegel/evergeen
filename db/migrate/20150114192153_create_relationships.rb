class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end

    ##
    # We will be finding relationships by follower_id and by followed_id,
    # so we add an index on each column for efficiency.
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id

    ##
    # Multiple-key index enforces uniqueness on (follower_id, followed_id)
    # pairs, so that a user can’t follow another user more than once. The
    # user interface won’t allow this to happen, but adding a unique index
    # arranges to raise an error if a user tries to create duplicate
    # relationships with a command-line tool for example.
    add_index :relationships, [:follower_id, :followed_id], unique: true

  end
end
