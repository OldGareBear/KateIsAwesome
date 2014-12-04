class RemoveNullConstraintsOnAdmirerName < ActiveRecord::Migration
  def change
    remove_column :admirers, :name
    
    add_column :admirers, :name, :string
  end
end
