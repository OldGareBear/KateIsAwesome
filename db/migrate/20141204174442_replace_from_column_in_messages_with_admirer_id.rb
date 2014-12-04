class ReplaceFromColumnInMessagesWithAdmirerId < ActiveRecord::Migration
  def change
    remove_column :messages, :from
    add_column :messages, :admirer_id, :integer
  end
end
