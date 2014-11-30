class ChangeFromIntegerToString < ActiveRecord::Migration
  def change
    remove_column :messages, :from
    add_column :messages, :from, :string
  end
end
