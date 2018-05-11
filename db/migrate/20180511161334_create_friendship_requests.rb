class CreateFriendshipRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friendship_requests do |t|
      t.integer :sender
      t.integer :receiver
      t.string :text
      t.string :expiration_date

      t.timestamps
    end
  end
end
