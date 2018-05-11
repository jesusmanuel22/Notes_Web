class CreateUserNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_notes do |t|
      t.integer :id_user
      t.integer :id_note

      t.timestamps
    end
  end
end
