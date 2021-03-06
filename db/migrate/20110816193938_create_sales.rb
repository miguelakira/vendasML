class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.string :title
      t.float :price
      t.float :tax
      t.float :cost
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
