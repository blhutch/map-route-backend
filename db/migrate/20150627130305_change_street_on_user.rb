class ChangeStreetOnUser < ActiveRecord::Migration
  def change
    rename_column :users, :Street, :street
  end
end
