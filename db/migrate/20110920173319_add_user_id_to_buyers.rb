class AddUserIdToBuyers < ActiveRecord::Migration
  def self.up
    add_column :buyers, :user_id, :integer
  end

  def self.down
    remove_column :buyers, :user_id
  end
end
