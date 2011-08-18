class AddTrackingToBuyer < ActiveRecord::Migration
  def self.up
    add_column :buyers, :tracking, :string
  end

  def self.down
    remove_column :buyers, :tracking
  end
end
