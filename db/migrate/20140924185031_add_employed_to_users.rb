class AddEmployedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :employed, :boolean
  end
end
