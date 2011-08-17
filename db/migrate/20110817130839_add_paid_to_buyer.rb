class AddPaidToBuyer < ActiveRecord::Migration
  def self.up
    add_column :buyers, :paid, :boolean
  end

  def self.down
    remove_column :buyers, :paid
  end
end
