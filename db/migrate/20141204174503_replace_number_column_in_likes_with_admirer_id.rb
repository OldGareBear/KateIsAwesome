class ReplaceNumberColumnInLikesWithAdmirerId < ActiveRecord::Migration
  def change
    remove_column :likes, :liker
    add_column :likes, :admirer_id, :integer
  end
end
