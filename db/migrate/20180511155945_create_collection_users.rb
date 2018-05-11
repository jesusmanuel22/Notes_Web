class CreateCollectionUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :collection_users do |t|
      t.integer :id_collection
      t.integer :id_user

      t.timestamps
    end
  end
end
