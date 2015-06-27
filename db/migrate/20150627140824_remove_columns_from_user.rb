class RemoveColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :street
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip
  end
end
