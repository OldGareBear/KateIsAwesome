class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :message_id, null: false
      t.string :liker, null: false

      t.timestamps
    end
  end
end
