class AddCityToBuyer < ActiveRecord::Migration
  def self.up
    add_column :buyers, :city, :string
  end

  def self.down
    remove_column :buyers, :city
  end
end
