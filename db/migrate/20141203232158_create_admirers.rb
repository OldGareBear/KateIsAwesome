class CreateAdmirers < ActiveRecord::Migration
  def change
    create_table :admirers do |t|
      t.string :name, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
