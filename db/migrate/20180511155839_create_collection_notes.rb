class CreateCollectionNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :collection_notes do |t|
      t.integer :id_collection
      t.integer :id_note

      t.timestamps
    end
  end
end
