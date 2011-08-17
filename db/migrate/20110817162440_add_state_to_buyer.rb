class AddStateToBuyer < ActiveRecord::Migration
  def self.up
    add_column :buyers, :state, :string
  end

  def self.down
    remove_column :buyers, :state
  end
end
