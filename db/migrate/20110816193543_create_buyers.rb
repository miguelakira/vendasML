class CreateBuyers < ActiveRecord::Migration
  def self.up
    create_table :buyers do |t|
      t.string :name
      t.string :email
      t.string :nickname
      t.integer :sale_id
      t.boolean :sent
      t.boolean :finished
      t.datetime :sent_at

      t.timestamps
    end
  end

  def self.down
    drop_table :buyers
  end
end
