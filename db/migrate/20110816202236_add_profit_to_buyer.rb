class AddProfitToBuyer < ActiveRecord::Migration
  def self.up
    add_column :buyers, :profit, :float
  end

  def self.down
    remove_column :buyers, :profit
  end
end
