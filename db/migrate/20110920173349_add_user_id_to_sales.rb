class AddUserIdToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :user_id, :integer
  end

  def self.down
    remove_column :sales, :user_id
  end
end
