class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from, null: false
      t.string :body, null: false
      t.string :city, null: false

      t.timestamps
    end
  end
end
